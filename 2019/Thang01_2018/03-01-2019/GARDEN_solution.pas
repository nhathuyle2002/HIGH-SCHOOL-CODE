{$MODE OBJFPC}
{$R-,Q-,S-,I-}
{$OPTIMIZATION LEVEL2}
{$INLINE ON}
program Garden;
const
  InputFile  = 'GARDEN.INP';
  OutputFile = 'GARDEN.OUT';
  maxMN = 2000;
  maxP = maxMN + maxMN;
  infty = 1E+100;
  eps = 1E-10;
type
  TArr = array[1..maxMN] of Extended;
  TBit1D = array[1..maxP] of Extended;
var
  fi, fo: TextFile;
  a, b: TArr;
  tree: array[1..maxMN] of TBit1D;
  m, n, p: Integer;
  len, h: Extended;

procedure Enter;
var
  i: Integer;
begin
  ReadLn(fi, len, h); len := len + eps;
  ReadLn(fi, m);
  for i := 1 to m do Read(fi, a[i]);
  ReadLn(fi, n);
  for i := 1 to n do Read(fi, b[i]);
  ReadLn(fi);
end;

function Distance(a, b: Extended): Extended; inline;
begin
  Result := Sqrt(Sqr(b - a) + Sqr(h));
end;

function Maximize(var target: Extended; value: Extended): Boolean; inline;
begin
  Result := target < value;
  if Result then target := value;
end;

procedure Sort(var a: TArr; n: Integer);

  procedure QSort(L, H: Integer);
  var
    i, j: Integer;
    pivot: extended;
  begin
    repeat
      if L >= H then Exit;
      i := L + Random(H - L + 1);
      pivot := a[i]; a[i] := a[L];
      i := L; j := H;
      repeat
        while (a[j] > pivot) and (i < j) do Dec(j);
        if i < j then
          begin
            a[i] := a[j]; Inc(i);
          end
        else Break;
        while (a[i] < pivot) and (i < j) do Inc(i);
        if i < j then
          begin
            a[j] := a[i]; Dec(j);
          end
        else Break;
      until i = j;
      a[i] := pivot;
      QSort(L, i - 1);
      L := i + 1;
    until false;
  end;

begin
  QSort(1, n);
end;

procedure UpdateY(var bit: TBit1D; y: Integer; value: Extended);
begin
  while y <= p do
    begin
      if not Maximize(bit[y], value) then Break;
      Inc(y, y and -y);
    end;
end;

procedure Update(x, y: Integer; value: Extended);
begin
  while x <= n do
    begin
      UpdateY(tree[x], y, value);
      Inc(x, x and -x);
    end;
end;

function FindY(const bit: TBit1D; threshold: Extended): Integer;
var
  y, next, mask: Integer;
begin
  mask := 1;
  while mask shl 1 <= p do mask := mask shl 1;
  y := 0; Result := maxP;
  while mask > 0 do
    begin
      if next <= p then
        begin
          next := y + mask;
          if bit[next] >= threshold then
            Result := next
          else
            y := next;
        end;
      mask := mask shr 1;
    end;
end;

function Find(x: Integer; threshold: Extended): Integer;
var
  resz: Integer;
begin
  Result := maxP + 1;
  while x > 0 do
    begin
      resz := FindY(tree[x], threshold);
      if Result > resz then Result := resz;
      x := x and Pred(x);
    end;
end;

function Optimize: Integer;
var
  x, y, z: Integer;
  d, f, g: Extended;
  res: Integer;
  nosol: Boolean;
begin
  p := m + n;
  for y := 1 to n do
    for z := 1 to p do
      tree[y, z] := -infty;
  nosol := True;
  res := -2;
  for x := 1 to m do
    for y := 1 to n do
      begin
        d := Distance(a[x], b[y]);
        if 2 * d <= len then nosol := False
        else Continue;
        f := a[x] + b[y] + d;
        z := x + y;
        Update(y, z, a[x] + b[y] - d);
        z := Find(y, f - len);
        if x + y - z > res then
          res := x + y - z;
      end;
  if nosol then Exit(0);
  Result := res + 2;
end;

procedure SolveAll;
var
  itest, ntest: Integer;
begin
  ReadLn(fi, ntest);
  for itest := 1 to ntest do
    begin
      Enter;
      Sort(a, m);
      Sort(b, n);
      WriteLn(fo, Optimize);
    end;
end;

begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
  try
    SolveAll;
  finally
    CloseFile(fi); CloseFile(fo);
  end;
end.
