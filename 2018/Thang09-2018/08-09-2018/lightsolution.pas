{$MODE OBJFPC}
{$INLINE ON}
program Lighting;
const
  InputFile  = 'LIGHT.INP';
  OutputFile = 'LIGHT.OUT';
  maxN = 2000;
  maxS = Round(1E9);
  infty = maxN * maxS + 1;
type
  TCandidate = record
    a, b, p: Integer;
  end;
  TTree = array[1..4 * maxN + 4] of Int64;
var
  e: array[0..maxN] of TCandidate;
  tree: TTree;
  leaf: array[0..maxN] of Integer;
  f: array[0..maxN, 0..maxN] of Int64;
  t: Integer;
  n: Integer;
  res: Int64;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n, t);
    for i := 1 to n do
      with e[i] do
        begin
          ReadLn(f, a, b, p);
          Dec(a, b); b := a + 2 * b;
          if a < 0 then a := 0;
          if b > t then b := t;
        end;
  finally
    CloseFile(f);
  end;
end;

procedure ShellSort;
var
  i, j, step: Integer;
  temp: TCandidate;
begin
  step := n div 2;
  while step <> 0 do
    begin
      for i := step + 1 to n do
        begin
          temp := e[i]; j := i - step;
          while (j > 0) and (e[j].b > temp.b) do
            begin
              e[j + step] := e[j];
              j := j - step;
            end;
          e[j + step] := temp;
        end;
      if step = 2 then step := 1
      else step := step * 10 div 22;
    end;
  with e[0] do
    begin
      a := 0; b := 0; p := 0;
    end;
end;

function BinarySearch(aj: Integer): Integer;
var
  L, M, H: Integer;
begin //tim k nho nhat, b[k] >= a[j]
  L := 0; H := n;
  repeat //b[L - 1] < aj <= b[H + 1]
    M := (L + H) div 2;
    if e[M].b < aj then L := M + 1
    else H := M - 1;
  until L > H;
  Result := L;
end;

procedure Build(x, L, H: Integer);
var
  m: Integer;
begin
  if L = H then
    leaf[L] := x
  else
    begin
      m := (L + H) shr 1;
      Build(x shl 1, L, m);
      Build(x shl 1 + 1, m + 1, H);
    end;
end;

procedure Preparation;
var
  i, j: Integer;
begin
  FillChar(f, SizeOf(f), Byte(-1));
  f[0, 0] := 0;
  for i := 1 to n do
    begin
      if e[i].a = 0 then
        begin
          f[0, i] := e[i].p;
          f[i, 0] := f[0, i];
        end;
      f[i, i] := infty;
    end;
  Build(1, 0, n);
end;

procedure ResetTree;
var
  i: Integer;
begin
  for i := 1 to 4 * (n + 1) do
    tree[i] := infty;
end;

function Min(x, y: Int64): Int64; inline;
begin
  if x < y then Result := x else Result := y;
end;

procedure Update(i: Integer; f: Int64);
begin
  i := leaf[i];
  tree[i] := f;
  while i > 1 do
    begin
      i := i shr 1;
      tree[i] := Min(tree[i shl 1], tree[i shl 1 + 1]);
    end;
end;

function Query(i, j: Integer): Int64;

  function Request(x, L, H: Integer): Int64;
  var
    m: Integer;
  begin
    if (H < i) or (j < L) then Exit(Infty);
    if (i <= L) and (H <= j) then Exit(tree[x]);
    m := (L + H) div 2;
    Result := Min(Request(x shl 1, L, m),
                  Request(x shl 1 + 1, m + 1, H));
  end;

begin
  if i > j then Exit(infty);
  Result := Request(1, 0, n);
end;

procedure SolveRecurrence;
var
  i, j, k: Integer;
begin
  for i := 0 to n do
    begin
      ResetTree;
      for j := 0 to i do
        Update(j, f[i, j]);
      for j := i + 1 to n do
        begin
          if f[i, j] = -1 then
            begin
              k := BinarySearch(e[j].a);
              f[i, j] := Query(k, j - 1);
              if f[i, j] < infty then
                Inc(f[i, j], e[j].p);
              f[j, i] := f[i, j];
            end;
          Update(j, f[i, j]);
        end;
    end;
  res := infty;
  for i := 1 to n do
    for j := 1 + i to n do
      if (e[i].b = t) and (e[j].b = t) and (res > f[i, j]) then
        res := f[i, j];
  if res = infty then res := -1;
  for i := 0 to n do
    begin
      for j := 0 to n do Write(stderr, f[i, j], ' ');
      WriteLn(stderr);
    end;
end;

procedure PrintResult;
var
  f: TextFile;
begin
  AssignFile(f, OutputFile); Rewrite(f);
  try
    Write(f, res);
  finally
    CloseFile(f);
  end;
end;

begin
  Enter;
  ShellSort;
  Preparation;
  SolveRecurrence;
  PrintResult;
end.
{
LIGHT.INP
7 12
2 2 11
6 2 11
10 2 11
4 4 33
8 4 33
6 6 99
10 1 1
LIGHT.OUT
88
}