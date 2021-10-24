{$MODE OBJFPC}
program NETSRV;

const
  InputFile = 'netsrv.inp';
  OutputFile = 'netsrv.out';
  maxN = 150000;
  maxQ = Round(1E5);
  maxlgN = 18;

type
  TAdj = record
    vertex: Integer;
    link: Integer;
  end;

  TInterval = record
    x1, x2, y: Integer;
    weight: Integer;
    close: Boolean;
    link: Integer;
  end;

  TTreeNode = record
    sum: Integer;
    max: Integer;
  end;

var
  fi, fo: TextFile;
  n, lgN: Integer;
  adj: array [-maxN + 1 .. maxN - 1] of TAdj;
  head: array [1 .. maxN] of Integer;
  parent: array [0 .. maxlgN, 1 .. maxN] of Integer;
  depth: array [1 .. maxN] of Integer;
  first, last: array [1 .. maxN] of Integer;
  it: array [1 .. 4 * maxQ] of TInterval;
  tree: array [1 .. 4 * maxN] of TTreeNode;
  leaf: array [1 .. maxN] of Integer;
  nit: Integer;
  q: Integer;
  res: Integer;

procedure Enter;
var
  i: Integer;
  x, y: Integer;
begin
  ReadLn(fi, n);
  lgN := Trunc(ln(n) / ln(2)) + 1;
  FillChar(head[1], SizeOf(head[1]) * n, 0);
  for i := 1 to n - 1 do
    begin
      ReadLn(fi, x, y);
      with adj[i] do
        begin
          vertex := y; link := head[x]; head[x] := i;
        end;
      with adj[-i] do
        begin
          vertex := x; link := head[y]; head[y] := -i;
        end;
    end;
end;

procedure DFS;
var
  time: Integer;

  procedure Visit(u: Integer; dv: Integer);
  var
    i: Integer;
  begin
    Inc(time); first[u] := time;
    depth[u] := dv;
    i := head[u];
    while i <> 0 do
      with adj[i] do
        begin
          if parent[0, vertex] = -1 then
            begin
              parent[0, vertex] := u; Visit(vertex, dv + 1);
            end;
          i := link;
        end;
    last[u] := time;
  end;

begin
  FillChar(parent[0, 1], SizeOf(parent[0, 1]) * n, $FF); // -1
  parent[0, 1] := 0;
  time := 0;
  Visit(1, 0);
end;

procedure InitFarJumpPtrs;
var
  level, u, v: Integer;
begin
  for level := 1 to lgN do
    for u := 1 to n do
      begin
        v := parent[level - 1, u];
        if v = 0 then
          parent[level, u] := 0
        else
          parent[level, u] := parent[level - 1, v];
      end;
end;

function Jump(u: Integer; k: Integer): Integer;
var
  i: Integer;
begin
  for i := 0 to lgN do
    begin
      if Odd(k) then
        u := parent[i, u];
      k := k div 2;
      if k = 0 then
        Break;
    end;
  Result := u;
end;

procedure ReadQueries;
var
  i, s, t, weight: Integer;

  procedure AddRect(_x1, _x2, _y1, _y2: Integer; _weight: Integer);
  begin
    Inc(nit);
    with it[nit] do
      begin
        x1 := _x1;
        x2 := _x2;
        y := _y1;
        close := False;
        weight := _weight;
      end;
    it[nit + 1] := it[nit];
    it[nit + 1].y := _y2;
    it[nit + 1].close := True;
    Inc(nit);
  end;

  procedure AddRects(s, t, w: Integer);
  var
    a, b, c, d, e, f: Integer;
    i, j, temp, u: Integer;
  begin
    if first[s] > first[t] then
      begin
        temp := s; s := t; t := temp;
      end;
    a := first[s]; b := last[s];
    c := first[t]; d := last[t];
    if b < c then
      begin
        AddRect(a, b, c, d, w);
        Exit;
      end;
    u := Jump(t, depth[t] - depth[s] - 1);
    e := first[u]; f := last[u];
    if 1 <= e - 1 then
      AddRect(1, e - 1, c, d, w);
    if f + 1 <= n then
      AddRect(c, d, f + 1, n, w);
  end;

begin
  ReadLn(fi, q);
  nit := 0;
  for i := 1 to q do
    begin
      ReadLn(fi, s, t, weight);
      AddRects(s, t, weight);
    end;
  FillChar(head[1], n * SizeOf(head[1]), 0);
  for i := 1 to nit do
    with it[i] do
      if close then
        begin
          link := head[y]; head[y] := i;
        end;
  for i := 1 to nit do
    with it[i] do
      if not close then
        begin
          link := head[y]; head[y] := i;
        end;
end;

procedure Build(x, Low, High: Integer);
var
  middle: Integer;
begin
  tree[x].sum := 0; tree[x].max := 0;
  if Low = High then
    leaf[low] := x
  else
    begin
      middle := (Low + High) shr 1;
      Build(x * 2, low, middle);
      Build(x * 2 + 1, middle + 1, High);
    end;
end;

function GetMax(a, b: Integer): Integer;
begin
  if a > b then Result := a else Result := b;
end;

procedure Increment(pos: Integer; delta: Integer);
var
  x: Integer;
begin
  if pos > n then
    Exit;
  x := leaf[pos];
  Inc(tree[x].sum, delta);
  Inc(tree[x].max, delta);
  repeat
    x := x shr 1;
    if x = 0 then
      Break;
    Inc(tree[x].sum, delta);
    tree[x].max := GetMax(tree[2 * x].max, tree[2 * x].sum + tree[2 * x + 1].max);
  until False;
end;

procedure ProcessInterval(const it: TInterval);
begin
  if not it.close then
    begin
      Increment(it.x1, it.weight);
      Increment(it.x2 + 1, -it.weight);
    end
  else
    begin
      Increment(it.x1, -it.weight);
      Increment(it.x2 + 1, it.weight);
    end;
  if res < tree[1].max then
    res := tree[1].max;
end;

function Solve: Integer;
var
  y, i: Integer;
begin
  Enter;
  DFS;
  InitFarJumpPtrs;
  ReadQueries;
  Build(1, 1, n);
  res := 0;
  for y := 1 to n do
    begin
      i := head[y];
      while i <> 0 do
        begin
          ProcessInterval(it[i]);
          i := it[i].link;
        end;
    end;
  Result := res;
end;

procedure SolveAll;
var
  itest, ntest: Integer;
begin
  ReadLn(fi, ntest);
  for itest := 1 to ntest do
    WriteLn(fo, Solve);
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
