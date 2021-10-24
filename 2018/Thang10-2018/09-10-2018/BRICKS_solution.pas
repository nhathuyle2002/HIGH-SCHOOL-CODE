{$MODE OBJFPC}
program TilingBricks;
uses Math;
const
  InputFile  = 'BRICKS.INP';
  OutputFile = 'BRICKS.OUT';
  maxSize = 200;
  maxN = maxSize * maxSize div 2;
  maxM = maxN * 4;
  maxV = 1000;
  maxW = maxV * maxV * 2;
  maxD = maxN * maxW + 1;
type
  THeap = record
    nItems: Integer;
    items, pos: array[1..maxN] of Integer;
  end;
  TEdge = record
    x, y: Integer;
    w: Integer;
    link: Integer;
  end;

var
  a: array[1..maxSize, 1..maxSize] of Integer;
  e: array[1..maxM] of TEdge;
  head: array[1..maxN] of Integer;
  m, n, k, nE: Integer;

  match: array[1..maxN] of Integer;
  f, g: array[1..maxN] of Int64;
  trace: array[1..maxN] of Integer;
  free: array[1..maxN] of Boolean;
  d: array[1..maxN] of Int64;
  z: array[1..maxN] of Integer;
  nz: Integer;

  Heap: THeap;
  Res: Int64;
  fi, fo: TextFile;

procedure Enter;
var
  i, j: Integer;
begin
  ReadLn(fi, m, n);
  m := m shl 1;
  n := n shl 1;
  for i := 1 to m do
    begin
      for j := 1 to n do Read(fi, a[i, j]);
      ReadLn(fi);
    end;
end;

procedure BuildGraph;
const
  dx: array[1..4] of Integer = (0, 0, 1, -1);
  dy: array[1..4] of Integer = (1, -1, 0, 0);
var
  i, j, i1, j1, p: Integer;
  d: Integer;
  black, white: Integer;
  map: array[1..maxSize, 1..maxSize] of Integer;
begin
  black := 0; white := 0;
  for i := 1 to m do
    for j := 1 to n do
      if Odd(i + j) then
        begin
          Inc(black); map[i, j] := black;
        end
      else
        begin
          Inc(white); map[i, j]:= white;
        end;
  nE := 0;
  for i := 1 to m do
    for j := 1 to n do
      if Odd(i + j) then
        for d := 1 to 4 do
          begin
            i1 := i + dx[d]; j1 := j + dy[d];
            if InRange(i1, 1, m) and InRange(j1, 1, n) then
              begin
                Inc(nE);
                e[nE].x := map[i, j];
                e[nE].y := map[i1, j1];
                e[nE].w := -a[i, j] * a[i1, j1];
              end;
          end;
  k := m * n div 2;
  FillDWord(head[1], k, 0);
  for p := 1 to nE do
    with e[p] do
      begin
        link := head[x]; head[x] := p;
      end;
end;

function Update(v: Integer; newD: Int64): Boolean;
var
  p, c: Integer;
begin
  Result := d[v] > newd;
  if not Result then Exit;
  with heap do
    begin
      d[v] := newd;
      c := pos[v];
      if c = 0 then
        begin
          Inc(nItems);
          c := nItems;
        end;
      repeat
        p := c div 2;
        if (p = 0) or (d[items[p]] <= newD) then Break;
        items[c] := items[p];
        pos[items[c]] := c;
        c := p;
      until False;
      items[c] := v;
      pos[v] := c;
    end;
end;

function Extract: Integer;
var
  v: Integer;
  p, c: Integer;
begin
  with heap do
    begin
      Result := items[1];
      v := items[nitems]; Dec(nitems);
      p := 1;
      repeat
        c := p * 2;
        if (c < nitems) and (d[items[c + 1]] < d[items[c]]) then Inc(c);
        if (c > nitems) or (d[v] <= d[items[c]]) then Break;
        items[p] := items[c];
        pos[items[p]] := p;
        p := c;
      until False;
      items[p] := v;
      pos[v] := p;
    end;
end;

function wp(const E: TEdge): Int64;
begin
  with e do Result := w + f[x] - g[y];
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to k do
    f[i] := maxw;
  FillChar(g[1], k * SizeOf(g[1]), 0);
  FillDWord(match[1], k, 0);
  with Heap do
    begin
      FillDWord(pos[1], k, 0);
      nItems := 0;
    end;
  for i := 1 to k do d[i] := maxD;
end;

procedure DijkstraInit(s: Integer);
var
  i: Integer;
begin
  heap.nItems := 0;
  i := head[s];
  while i <> 0 do
    with e[i] do
      begin
        Update(y, wp(e[i]));
        trace[y] := 0;
        i := link;
      end;
  nz := 0;
end;

procedure DijkstraDestroy;
var
  i: Integer;
begin
  for i := 1 to nz do
    begin
      d[z[i]] := maxD;
      heap.pos[z[i]] := 0;
    end;
  with heap do
    for i := 1 to nItems do
      begin
        d[items[i]] := maxD;
        pos[items[i]] := 0;
      end;
  heap.nItems := 0;
  nz := 0;
end;

function Dijkstra(s: Integer): Integer;
var
  ux, uy: Integer;
  i: Integer;
begin
  DijkstraInit(s);
  repeat
    uy := Extract; ux := match[uy];
    Inc(nz); z[nz] := uy;
    if ux = 0 then Break;
    i := head[ux];
    while i <> 0 do
      with e[i] do
        begin
          if Update(y, d[uy] + wp(e[i])) then
            trace[y] := uy;
          i := link;
        end;
  until False;
  Result := uy;
  for i := 1 to nz do
    begin
      uy := z[i]; ux := match[uy];
      if ux <> 0 then
        begin
          Inc(f[ux], d[uy] - d[Result]);
          Inc(g[uy], d[uy] - d[Result]);
        end;
    end;
  Inc(f[s], -d[Result]);
  DijkstraDestroy;
end;

procedure Enlarge(s, t: Integer);
var
  next: Integer;
begin
  repeat
    next := trace[t];
    if next = 0 then Break;
    match[t] := match[next];
    t := next;
  until False;
  match[t] := s;
end;

procedure Solve;
var
  s, t, i: Integer;
begin
  for s := 1 to k do
    begin
      t := Dijkstra(s);
      Enlarge(s, t);
    end;
  Res := 0;
  for i := 1 to k do
    Inc(Res, f[i] - g[i]);
end;

begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
  try
    Enter;
    BuildGraph;
    Init;
    Solve;
    Write(fo, res);
  finally
    CloseFile(fi); CloseFile(fo);
  end;
end.

2 3
 1  2  4  7  2  7
 1  7 -1  2  3 -2
-1 -4  7 -8  9 -4
-2  0  6  6  1  0


