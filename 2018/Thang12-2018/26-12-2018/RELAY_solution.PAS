{$MODE OBJFPC}
program Relay;
const
  InputFile  = 'RELAY.INP';
  OutputFile = 'RELAY.OUT';
  maxN = Round(1E5);
  turtle = Round(1E18) + 1;
type
  TRacer = record
    a, b, c, xid1, xid2: Integer;
  end;
  TLine = record
    x1, x2, d: Integer;
    y1, y2: Int64;
  end;
  TNode = record
    line: TLine;
    L, H: Integer;
  end;
var
  r: array[1..maxN] of TRacer;
  xarr: array[1..maxN] of Integer;
  tree: array[1..4 * maxN] of TNode;
  leaf: array[1..maxN] of Integer;
  nx: Integer;
  n, k: Integer;
  fi, fo: TextFile;
  res: Int64;

procedure Sort(L, H: Integer);
var
  i, j: Integer;
  pivot: TRacer;
begin
  repeat
    if L >= H then Exit;
    i := L + Random(H - L + 1);
    pivot := r[i]; r[i] := r[L];
    i := L; j := H;
    repeat
      while (r[j].a > pivot.a) and (i < j) do Dec(j);
      if i < j then
        begin
          r[i] := r[j]; Inc(i);
        end
      else Break;
      while (r[i].a < pivot.a) and (i < j) do Inc(i);
      if i < j then
        begin
          r[j] := r[i]; Dec(j);
        end
      else Break;
    until i = j;
    r[i] := pivot;
    Sort(L, i - 1);
    L :=  i + 1;
  until False;
end;

procedure Enter;
var
  i: Integer;
begin
  ReadLn(fi, n, k);
  for i := 1 to n do
    with r[i] do ReadLn(fi, a, b, c);
  Sort(1, n);
end;

procedure MakeLine(var res: TLine; a, b, c: Integer; start: Int64);
begin
  res.x1 := a; res.x2 := b; res.d := c;
  res.y1 := start; res.y2 := Int64(b - a) * c + start;
end;

function Time(const l: TLine; x: Integer): Int64;
begin
  with l do
    Result := Int64(x - x1) * d + y1;
end;

procedure Build(node: Integer; low, high: Integer);
var
  middle: Integer;
begin
  with tree[node] do
    begin
      L := low; H := high;
      MakeLine(line, xarr[L], xarr[H], 0, turtle);
      if low = high then
        leaf[low] := node
      else
        begin
          middle := (low + high) div 2;
          Build(node * 2, low, middle);
          Build(node * 2 + 1, middle + 1, high);
        end;
    end;
end;

function Search(xv: Integer): Integer;
var
  low, middle, high: Integer;
begin
  low := 1; high := nx;
  while (low <= high) do //xarr[low - 1] <= xv < xarr[high + 1]
    begin
      middle := (low + high) shr 1;
      if xarr[middle] <= xv then low := Succ(middle)
      else high := Pred(middle);
    end;
  Result := high;
end;

procedure Init;
var
  i: Integer;
  old: Integer;
begin
  nx := 0;
  old := -1;
  for i := 1 to n do
    begin
      if r[i].a <> old then
        begin
          old := r[i].a;
          Inc(nx);
          xarr[nx] := old;
        end;
      r[i].xid1 := nx;
    end;
  for i := 1 to n do
    r[i].xid2 := Search(r[i].b);
  Build(1, 1, nx);
end;

procedure PartialLine(var newline: TLine; const line: TLine;
  x1, x2: Integer);
begin
  newline.x1 := x1;
  newline.x2 := x2;
  newline.d := line.d;
  newline.y1 := Time(line, x1);
  newline.y2 := TIme(line, x2);
end;

procedure Swap(var l1, l2: TLine);
var
  temp: TLine;
begin
  temp := l1; l1 := l2; l2 := temp;
end;

procedure UpdateNode(node: Integer; var aline: TLine);
var
  M, xM: Integer;
  subline: TLine;
begin
  with tree[node] do
    begin
      if (line.y1 <= aline.y1) and (line.y2 <= aline.y2) then
        Exit;
      if (line.y1 >= aline.y1) and (line.y2 >= aline.y2) then
        begin
          line := aline; Exit;
        end;
      if line.y1 < aline.y1 then
        Swap(line, aline);
      M := (L + H) div 2;
      xM := xarr[M];
      if Time(line, xM) <= Time(aline, XM) then
        begin
          PartialLine(subline, aline, xarr[L], xarr[M]);
          UpdateNode(node shl 1, subline);
        end
      else
        begin
          PartialLine(subline, line, xarr[M + 1], xarr[H]);
          line := aline;
          UpdateNode(node shl 1 + 1, subline);
        end;
    end;
end;

procedure InsertToTree(node: Integer; const aline: TLine);
var
  templine: TLine;
begin
  with tree[node] do
    begin
      if (aline.x1 > xarr[H]) or (aline.x2 < xarr[L]) then Exit;
      if (aline.x1 <= xarr[L]) and (aline.x2 >= xarr[H]) then
        begin
          PartialLine(templine, aline, xarr[L], xarr[H]);
          UpdateNode(node, templine);
          Exit;
        end;
      InsertToTree(node shl 1, aline);
      InsertToTree(node shl 1 + 1, aline);
   end;
end;

function Query(xid: Integer): Int64;
var
  x: Integer;
  node: Integer;
  temp: Int64;
begin
  node := leaf[xid];
  x := xarr[xid];
  Result := Time(tree[node].line, x);
  repeat
    node := node shr 1;
    if node = 0 then Break;
    temp := Time(tree[node].line, x);
    if temp < Result then Result := temp;
  until False;
end;

procedure Solve;
var
  i: Integer;
  line: TLine;
  starttime, finishtime: Int64;
begin
  MakeLine(line, 0, 0, 0, 0);
  InsertToTree(1, line);
  res := turtle;
  for i := 1 to n do
    begin
      starttime := Query(r[i].xid1);
      with r[i] do MakeLine(line, a, b, c, starttime);
      if r[i].b = k then
        begin
          finishtime := line.y2;
          if finishtime < res then
            res := finishtime;
        end;
      InsertTotree(1, line);
    end;
end;

begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
  try
    Enter;
    Init;
    Solve;
    Write(fo, res);
  finally
    CloseFile(fi); CloseFile(fo);
  end;
end.
