{$MODE OBJFPC}
program Assignment;
const
  InputFile  = 'ASSIGN.INP';
  OutputFile = 'ASSIGN.OUT';
  maxN = 10000;
  maxM = 100000;
  maxW = 100000;
  infty = maxN * maxW;
type
  TEdge = record
    x, y, w: Integer;
  end;
  THeap = record
    nItems: Integer;
    items: array[1..maxN] of Integer;
    pos: array[1..maxN] of Integer;
  end;
var
  n, m: Integer;
  e: array[1..maxM] of TEdge;
  link: array[1..maxM] of Integer;
  head: array[1..maxN] of Integer;
  f, g: array[1..maxN] of Integer;
  d: array[1..maxN] of Integer;
  match: array[1..maxN] of Integer;
  trace: array[1..maxN] of Integer;
  z: array[1..maxN] of Integer;
  nz: Integer;
  list: array[1..maxN] of Integer;
  nlist: Integer;
  Heap: THeap;
  cost: Integer;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n, m);
    for i := 1 to m do
      with e[i] do ReadLn(f, x, y, w);
  finally
    CloseFile(f);
  end;
end;

function wp(const e: TEdge): Integer;
begin
  with e do
    Result := w - f[x] - g[y];
end;

procedure Init;
var
  i, j, k: Integer;
begin
  FillDWord(head[1], n, 0);
  for k := m downto 1 do
    with e[k] do
      begin
        link[k] := head[x];
        head[x] := k;
      end;
  FillDWord(f[1], n, infty);
  for k := 1 to m do
    with e[k] do
      if f[x] > w then f[x] := w;
  FillDWord(g[1], n, infty);
  for k := 1 to m do
    with e[k] do
      if g[y] > w - f[x] then g[y] := w - f[x];
  //Greedy
  FillDWord(match[1], n, 0);
  nlist := 0;
  for i := 1 to n do
    begin
      j := 0;
      k := head[i];
      while k <> 0 do
        begin
          if (wp(e[k]) = 0) and (match[e[k].y] = 0) then
            begin
              j := e[k].y;
              Break;
            end;
          k := link[k];
        end;
      if j <> 0 then match[j] := i
      else
        begin
          Inc(nlist);
          list[nlist] := i;
        end;
    end;
end;

function HeapExtract: Integer;
var
  p, c: Integer;
  y: Integer;
begin
  with Heap do
    begin
      Result := items[1];
       y := items[nItems]; Dec(nItems);
      p := 1;
      repeat
        c := p * 2;
        if (c < nItems) and (d[items[c + 1]] < d[items[c]]) then Inc(c);
        if (c > nItems) or (d[items[c]] >= d[y]) then Break;
        items[p] := items[c]; pos[items[p]] := p;
        p := c;
      until False;
      items[p] := y; pos[y] := p;
    end;
end;

function HeapUpdate(y: Integer; dy: Integer): Boolean;
var
  p, c: Integer;
begin
  if d[y] <= dy then Exit(False);
  d[y] := dy;
  Result := True;
  with Heap do
    begin
      c := pos[y];
      if c = 0 then
        begin
          Inc(nItems);c := nItems;
        end;
      repeat
        p := c div 2;
        if (p = 0) or (d[items[p]] <= dy) then Break;
        items[c] := items[p]; pos[items[c]] := c;
        c := p;
      until False;
      items[c] := y; pos[y] := c;
    end;
end;

procedure DijkstraInit(s: Integer);
var
  j, k: Integer;
begin
  FillDWord(d[1], n, infty);
  FillDWord(trace[1], n, 0);
  with heap do
    begin
      FillDWord(pos[1], n, 0);
      nItems := 0;
    end;
  k := head[s];
  while k <> 0 do
    begin
      j := e[k].y;
      HeapUpdate(j, wp(e[k]));
      k := link[k];
    end;
  nz := 0;
end;

function Dijkstra(s: Integer): Integer;
var
  i, j, jmin: Integer;
  k: Integer;
begin;
  DijkstraInit(s);
  while Heap.nItems > 0 do
    begin
      jmin := HeapExtract; i := match[jmin];
      if i = 0 then Exit(jmin);
      Inc(nz); z[nz] := jmin;
      k := head[i];
      while k <> 0 do
        begin
          j := e[k].y;
          if HeapUpdate(j, d[jmin] + wp(e[k])) then
            trace[j] := jmin;
          k := link[k];
        end;
    end;
  Result := 0;
end;

procedure UpdatePotentials(s, t: Integer);
var
  i, j, k: Integer;
begin
  for k := 1 to nz do
    begin
      j := z[k]; i := match[j];
      Inc(f[i], d[t] - d[j]);
      Dec(g[j], d[t] - d[j]);
    end;
  Inc(f[s], d[t]);
end;

procedure Enlarge(s, t: Integer);
var
  y: Integer;
begin
  repeat
    y := trace[t];
    if y = 0 then Break;
    match[t] := match[y];
    t := y;
  until False;
  match[t] := s;
end;

procedure SuccessiveShortestPaths;
var
  s, t: Integer;
  p: Integer;
begin
  for p := 1 to nlist do
    begin
      s := list[p];
      t := Dijkstra(s);
      UpdatePotentials(s, t);
      Enlarge(s, t);
    end;
end;

procedure PrintResult;
var
  fo: TextFile;
  i, j: Integer;
begin
  cost := 0;
  for j := 1 to n do
    begin
      i := match[j];
      Inc(cost, f[i] + g[j]);
    end;
  AssignFile(fo, OutputFile); Rewrite(fo);
  try
    WriteLn(fo, cost);
    for j := 1 to n do Write(fo, match[j], ' ');
  finally
    CloseFile(fo);
  end;
end;

begin
  Enter;
  Init;
  SuccessiveShortestPaths;
  PrintResult;
end.
3 6
1 1 1
1 3 3
2 1 3
2 2 2
3 2 3
3 3 7

1 1 0
1 2 0
2 1 0
2 4 2
3 2 1
3 3 0
4 3 0
4 4 9
