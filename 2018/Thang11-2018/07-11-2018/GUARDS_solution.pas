{$MODE OBJFPC}
program BodyGuards;
const
  InputFile  = 'GUARDS.INP';
  OutputFile = 'GUARDS.OUT';
  maxN = 100000;
type
  TGuard = record
    s, f: Integer;
    id: Integer;
    Selected: Boolean;
  end;
  PGuard = ^TGuard;
  TCmpFunc = function (x, y: PGuard): Integer;
  THeap = record
    nItems: Integer;
    Items: array[1..maxN] of PGuard;
    Compare: TCmpFunc;
  end;
var
  temp: array[1..maxN] of TGuard;
  Guard: array[1..maxN] of PGuard;
  n, k, A, B: Integer;
  MinHeap, MaxHeap: THeap;
  Sentinel: TGuard;
  res: Integer;

procedure Enter;
var
  fi: TextFile;
  i: Integer;
begin
  AssignFile(fi, InputFile); Reset(fi);
  try
    ReadLn(fi, n, k, A, B);
    for i := 1 to n do
      begin
        Guard[i] := @temp[i];
        with Guard[i]^ do
          begin
            ReadLn(fi, s, f);
            id := i;
            Selected := False;
          end;
      end;
  finally
    CloseFile(fi);
  end;
end;

procedure Sort(L, H: Integer);
var
  i, j: Integer;
  Pivot: PGuard;
begin
  if L >= H then Exit;
  i := L + Random(H - L + 1);
  Pivot := Guard[i]; Guard[i] := Guard[L];
  i := L; j := H;
  repeat
    while (Guard[j]^.s > Pivot^.s) and (i < j) do Dec(j);
    if i < j then
      begin
        Guard[i] := Guard[j]; Inc(i);
      end
    else Break;
    while (Guard[i]^.s < Pivot^.s) and (i < j) do Inc(i);
    if i < j then
      begin
        Guard[j] := Guard[i]; Dec(j);
      end
    else Break;
  until i = j;
  Guard[i] := Pivot;
  Sort(L, i - 1); Sort(i + 1, H);
end;

function MinHeapCompare(x, y: PGuard): Integer;
begin
  if x^.f < y^.f then Result := 1
  else
    if x^.f = y^.f then Result := 0
    else Result:= -1;
end;

function MaxHeapCompare(x, y: PGuard): Integer;
begin
  if x^.f > y^.f then Result := 1
  else
    if x^.f = y^.f then Result := 0
    else Result := -1;
end;

procedure Init;
var
  i: Integer;
begin
  MinHeap.Compare := @MinHeapCompare;
  MaxHeap.Compare := @MaxHeapCompare;
  Sentinel.f := A;
  MinHeap.nItems := k;
  for i := 1 to k do
    MinHeap.Items[i] := @Sentinel;
  MaxHeap.nItems := 0;
end;

procedure UpHeap(var Heap: THeap; c: Integer);
var
  p: Integer;
  temp: PGuard;
begin
  with Heap do
    begin
      temp := Items[c];
      repeat
        p := c div 2;
        if (p = 0) or (Compare(Items[p], temp) >= 0) then Break;
        Items[c] := Items[p];
        c := p;
      until False;
      Items[c] := temp;
    end;
end;

procedure DownHeap(var Heap: THeap; p: Integer);
var
  c: Integer;
  temp: PGuard;
begin
  with Heap do
    begin
      temp := Items[p];
      repeat
        c := p * 2;
        if (c < nItems) and (Compare(Items[c], Items[c + 1]) < 0) then
          Inc(c);
        if (c > nItems) or (Compare(Items[c], temp) <= 0) then Break;
        Items[p] := Items[c];
        p := c;
      until False;
      Items[p] := temp;
    end;
end;

function Get(const Heap: THeap): PGuard;
begin
  Result := Heap.Items[1];
end;

procedure Insert(var Heap: THeap; Guard: PGuard);
begin
  with Heap do
    begin
      Inc(nItems);
      Items[nItems] := Guard;
      UpHeap(Heap, nItems);
    end;end;

function Extract(var Heap: THeap): PGuard;
begin
  Result := Get(Heap);
  with Heap do
    begin
      Items[1] := Items[nItems];
      Dec(nItems);
      DownHeap(Heap, 1);
    end;
end;

procedure Solve;
var
  G: PGuard;
  Time: Integer;
  i: Integer;
begin
  i := 1;
  res := 0;
  repeat
    G := Get(MinHeap); Time := G^.f;
    if (Time >= b) and (res >= k) then
      Break;
    while (i <= n) and (Guard[i]^.s <= Time) do
      begin
        Insert(MaxHeap, Guard[i]);
        Inc(i);
      end;
    if MaxHeap.nItems = 0 then Break;
    G := Extract(MaxHeap);
    G^.Selected := True;
    Inc(res);
    MinHeap.Items[1] := G;
    DownHeap(MinHeap, 1);
  until False;
  if (Time < b) or (res < k) then res := -1;
end;

procedure PrintResult;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, OutputFile); Rewrite(f);
  try
    WriteLn(f, res);
    if res >= 0 then
      for i := 1 to n do
        if Guard[i]^.Selected then Write(f, Guard[i]^.id, ' ');
  finally
    CloseFile(f);
  end;
end;

begin
  Enter;
  Sort(1, n);
  Init;
  Solve;
  PrintResult;
end.
5 2 1 9
1 5
4 9
1 3
1 7
5 9
