{$MODE OBJFPC}
program ProblemSolver;
const
  InputFile  = 'VCPAIRS.INP';
  OutputFile = 'VCPAIRS.OUT';
  maxN = Round(1E5);
type
  PNode = ^TNode;
  TNode = packed record
    value: Integer;
    freq: Integer;
    P, L, R: PNode;
  end;
var
  fi, fo: TextFile;
  lab, color: array[1..maxN] of Integer;
  n, m: Integer;
  sentinel, pattern: TNode;
  nilT: PNode;
  ColorSet: array[1..maxN] of PNode;

procedure Enter;
var
  i: Integer;
  u, v, w: Integer;
begin
  ReadLn(fi, n, m);
  for i := 1 to n do Read(fi, color[i]);
  ReadLn(fi);
end;

procedure Init;
begin
  nilT := @sentinel;
  with pattern do
    begin
      P := nilT; L := nilT; R := nilT;
    end;
  sentinel := pattern;
end;

procedure SetL(x, y: PNode); inline;
begin
  y^.P := x; x^.L := y;
end;

procedure SetR(x, y: PNode); inline;
begin
  y^.P := x; x^.R := y;
end;

procedure SetC(x, y: PNode; InRight: Boolean); inline;
begin
  if InRight then SetR(x, y)
  else SetL(x, y);
end;

procedure UpTree(x: PNode);
var
  y, z: PNode;
begin
  y := x^.P; z := y^.P;
  if x = y^.L then
    begin
      SetC(y, x^.R, False);
      SetC(x, y, True);
    end
  else
    begin
      SetC(y, x^.L, True);
      SetC(x, y, False);
    end;
  SetC(z, x, z^.R = y);
end;

procedure Splay(x: PNode);
var
  y, z: PNode;
begin
  repeat
    y := x^.P;
    if y = nilT then Break;
    z := y^.P;
    if z <> nilT then
      if (x = y^.L) = (y = z^.L) then UpTree(y)
      else UpTree(x);
    UpTree(x);
  until False;
end;

function Insert(var T: PNode; key, f: Integer): Int64;
var
  x, last: PNode;
begin
  repeat
    last := T;
    if T^.value = key then Break;
    if key < T^.value then T := T^.L
    else T := T^.R;
  until T = nilT;
  if T = nilT then
    begin
      Result := 0;
      New(x);
      x^ := pattern;
      x^.value := key; x^.freq := f;
      if key < last^.value then SetC(last, x, False)
      else SetC(last, x, True);
      Splay(x);
      T := x;
    end
  else
    begin
      Result := Int64(T^.freq) * f;
      Inc(T^.freq, f);
      Splay(T);
    end;
end;

function UnionSet(var r, s: PNode): Int64;

  procedure Visit(x: PNode);
  begin
    if x = nilT then Exit;
    Inc(Result, Insert(r, x^.value, x^.freq));
    Visit(x^.L);
    Visit(x^.R);
    Dispose(x);
  end;

begin
  Result := 0;
  Visit(s);
  s := nilT;
end;

function MakeSet(u: Integer): PNode;
begin
  lab[u] := -1;
  New(Result); Result^ := pattern;
  with Result^ do
    begin
      value := color[u];
      freq := 1;
    end;
end;

function FindSet(u: integer): Integer;
begin
  if lab[u] < 0 then Exit(u);
  Result := FindSet(lab[u]);
  lab[u] := Result;
end;

function Union(r, s: Integer): Integer;
var
  x: Integer;
begin
  x := lab[r] + lab[s];
  if lab[r] < lab[s] then
    begin
      lab[s] := r; lab[r] := x;
      Result := r;
    end
  else
    begin
      lab[r] := s; lab[s] := x;
      Result := s;
    end;
end;

procedure Solve;
var
  i: Integer;
  r, s, x, u, v: Integer;
  ans: Int64;
begin
  for i := 1 to n do
    ColorSet[i] := MakeSet(i);
  ans := 0;
  for i := 1 to m do
    begin
      ReadLn(fi, u, v);
      r := FindSet(u); s := FindSet(v);
      if r <> s then
        begin
          x := Union(r, s);
          if x = r then
            Inc(ans, UnionSet(ColorSet[r], ColorSet[s]))
          else
            Inc(ans, UnionSet(ColorSet[s], ColorSet[r]));
        end;
      WriteLn(fo, ans);
    end;
end;

procedure FreeSets;
var
  i: Integer;

  procedure Visit(x: PNode);
  begin
    if x = nilT then Exit;
    Visit(x^.L);
    Visit(x^.R);
    Dispose(x);
  end;

begin
  for i := 1 to n do
    if ColorSet[i] <> nilT then Visit(ColorSet[i]);
end;

begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, Outputfile); Rewrite(fo);
  try
    Enter;
    Init;
    Solve;
    FreeSets;
  finally
    CloseFile(fi); CloseFile(fo);
  end;
end.
