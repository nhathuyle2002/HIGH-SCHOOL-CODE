{$MODE OBJFPC}
{$INLINE ON}
program ShufflingMachine;
uses Math;
const
  InputFile  = 'SHUFFLE.INP';
  OutputFile = 'SHUFFLE.OUT';
  maxN = 1000000000;
  maxM = 100000;
type
  PNode = ^TNode;
  TNode = record
    inf, sup: Integer;
    size: Integer;
    P, L, R: PNode;
  end;
var
  fi, fo: TextFile;
  n, m: Integer;
  root, nilT: PNode;
  Sentinel: TNode;
  a: array[1..maxM * 2 + 1] of Integer;
  w: array[1..maxM * 2 + 1] of Integer;
  bit: array[1..maxM * 2 + 1] of Integer;
  id: array[1..maxM * 2 + 1] of Integer;
  lena: Integer;
  res: Integer;

procedure OpenFiles;
begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
end;

procedure CloseFiles;
begin
  CloseFile(fi); CloseFile(fo);
end;

procedure Init(n: Integer);
begin
  New(root);
  root^.inf := 0; root^.sup := 2 * n;
  root^.size := 2 * n;
  root^.P := nilT; root^.L := nilT; root^.R := nilT;
end;

procedure Destroy(x: PNode);
begin
  if x = nilT then Exit;
  Destroy(x^.L); Destroy(x^.R);
  Dispose(x);
end;

procedure SetLink(Parent, Child: PNode; InLeft: Boolean); inline;
begin
  Child^.P := Parent;
  if InLeft then Parent^.L := Child else Parent^.R := Child;
end;

function Len(x: PNode): Integer; inline;
begin
  Result := x^.sup - x^.inf;
end;

procedure Update(x: PNode); inline;
begin
  x^.size := x^.L^.size + x^.R^.size + Len(x);
end;

procedure UpTree(x: PNode);
var
  y, z, b: PNode;
begin
  y := x^.P; z := y^.P;
  if x = y^.L then
    begin
      b := x^.R;
      SetLink(y, b, True);
      SetLink(x, y, False);
    end
  else
    begin
      b := x^.L;
      SetLink(y, b, False);
      SetLink(x, y, True);
    end;
  SetLink(z, x, z^.L = y);
  Update(y); Update(x);
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
      if (y = z^.L) = (x = y^.L) then UpTree(y)
      else UpTree(x);
    UpTree(x);
  until False;
end;

function NodeAt(T: PNode; i: Integer): PNode;
var
  order1, order2: Integer;
  x: PNode;
begin
  repeat
    order1 := T^.L^.size + 1;
    order2 := order1 + Len(T) - 1;
    if InRange(i, order1, order2) then Break;
    if i < order1 then T := T^.L
    else  //i > order2
      begin
        T := T^.R;
        Dec(i, order2);
      end;
  until False;
  if i < order2 then
    begin
      New(x);
      x^.sup := T^.sup;
      x^.inf := T^.sup - (order2 - i);
      SetLink(x, T^.R, False);
      x^.L := nilT;
      Update(x);
      T^.sup := x^.inf;
      SetLink(T, x, False);
      Update(T);
    end;
  Result := T;
end;

procedure Split(T: PNode; i: Integer; var TL, TR: PNode);
begin
  if i = 0 then
    begin
      TL := nilT; TR := T; Exit;
    end;
  TL := NodeAt(T, i);
  Splay(TL);
  TR := TL^.R;
  TL^.R := nilT; TR^.P := nilT;
  Update(TL);
  Update(TR);
end;

function Join(TL, TR: PNode): PNode;
begin
  if TL = nilT then Exit(TR);
  while TL^.R <> nilT do
    TL := TL^.R;
  Splay(TL);
  SetLink(TL, TR, False);
  Update(TL);
  Result := TL;
end;

procedure DoShuffle(k: Integer);
var
  T1, T2, T3: PNode;
begin
  Split(root, n - Abs(k), T1, T2);
  Split(T2, 2 * Abs(k), T2, T3);
  if k > 0 then
    root := Join(Join(T2, T1), T3)
  else
    root := Join(Join(T1, T3), T2);
end;

procedure ToArray;

  procedure Visit(x: PNode);
  begin
    if x = nilT then Exit;
    Visit(x^.L);
    Inc(lena);
    a[lena] := x^.sup;
    w[lena] := Len(x);
    Visit(x^.R);
  end;

begin
  lena := 0;
  Visit(root);
end;

procedure Sort(L, H: Integer);
var
  i, j: Integer;
  pivot: Integer;
begin
  if L >= H then Exit;
  i := L + Random(H - L + 1);
  pivot := id[i]; id[i] := id[L];
  i := L; j := H;
  repeat
    while (a[id[j]] > a[pivot]) and (i < j) do Dec(j);
    if i < j then
      begin
        id[i] := id[j]; Inc(i);
      end
    else Break;
    while (a[id[i]] < a[pivot]) and (i < j) do Inc(i);
    if i < j then
      begin
        id[j] := id[i]; Dec(j);
      end
    else Break;
  until i = j;
  id[i] := pivot;
  Sort(L, i - 1); Sort(i + 1, H);
end;

procedure UpdateBIT(x: Integer; fx: Integer); inline;
begin
  repeat
    if fx <= bit[x] then Break;
    bit[x] := fx;
    Inc(x, (x and -x));
  until x > lena;
end;

function QueryBIT(x: Integer): Integer; inline;
begin
  Result := 0;
  while x > 0 do
    begin
      Result := Max(Result, bit[x]);
      x := x and Pred(x);
    end;
end;

procedure Optimize;
var
  i, j: Integer;
begin
  FillDWord(bit[1], lena, 0);
  for i := 1 to lena do
    begin
      j := id[i];
      UpdateBIT(j, QueryBIT(j - 1) + w[j]);
    end;
  res := n shl 1 - QueryBIT(lena);
end;

procedure SolveAll;
var
  icase: Integer;
  j: Integer;
  k: Integer;
begin
  nilT := @sentinel;
  nilT^.size := 0;
  nilT^.inf := 1; nilT^.sup := 0;
  ReadLn(fi, n, m);
  Init(n);
  try
    for j := 1 to m do
      begin
        Read(fi, k);
        DoShuffle(k);
      end;
    ReadLn(fi);
    ToArray;
  finally
    Destroy(root);
  end;
  for j := 1 to lena do
    id[j] := j;
  Sort(1, lena);
  Optimize;
  WriteLn(fo, res);
end;

begin
  OpenFiles;
  try
    SolveAll;
  finally
    CloseFiles;
  end;
end.
2
3 2
-2 1
1000000000 3
999999999 -1 2
