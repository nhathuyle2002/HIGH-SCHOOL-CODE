{$MODE OBJFPC}
{$M 30000000}
{$DEFINE RELEASE}
{$R-,Q-,S-,I-}
{$OPTIMIZATION LEVEL2}
{$INLINE ON}
program Traffic;
const
  InputFile  = 'TRAFFIC.INP';
  OutputFile = 'TRAFFIC.OUT';
  maxN = Round(1E5);
  maxM = Round(2E5);
type
  TEdge = record
    x, y: Integer;
    link: Integer;
  end;
  TMarkArr = array[1..maxN] of Boolean;
var
  n, m, savem: Integer;
  e: array[1..maxM + maxN] of TEdge;
  head: array[1..maxN] of Integer;
  num, low, stack, lab: array[1..maxN] of Integer;
  top: Integer;
  noI, noO: TMarkArr;
  fi, fo: TextFile;

procedure Enter;
var
  i: Integer;
begin
  ReadLn(fi, n, m);
  for i := 1 to m do
    with e[i] do ReadLn(fi, x, y);
  savem := m;
end;

procedure BuildIncidentLists;
var
  i: Integer;
begin
  FillDWord(head[1], n, 0);
  for i := 1 to m do
    with e[i] do
      begin
        link := head[x]; head[x] := i;
      end;
end;

procedure Push(u: Integer); inline;
begin
  Inc(top); stack[top] := u;
end;

function Pop: Integer; inline;
begin
  Result := stack[top]; Dec(top);
end;

procedure Minimize(var target: Integer; value: Integer); inline;
begin
  if target > value then target := value;
end;

procedure FindSCCs;
var
  count: Integer;
  i: Integer;

  procedure Visit(u: Integer);
  var
    i: Integer;
  begin
    Inc(count); num[u] := count; low[u] := maxN + 1;
    Push(u);
    i := head[u];
    while i <> 0 do with e[i] do
      begin
        if num[y] = 0 then
          begin
            Visit(y);
            Minimize(low[u], low[y]);
          end
        else
          if num[y] > 0 then
            Minimize(low[u], num[y]);
        i := link;
      end;
    if low[u] >= num[u] then
      repeat
        i := Pop;
        lab[i] := u;
        num[i] := -1;
      until i = u;
  end;

begin
  FillDWord(num[1], n, 0);
  top := 0;
  count := 0;
  for i := 1 to n do
    if num[i] = 0 then Visit(i);
end;

procedure FindNoIO;
var
  i: Integer;
begin
  for i := 1 to n do
    begin
      noI[i] := lab[i] = i;
      noO[i] := lab[i] = i;
    end;
  for i := 1 to m do with e[i] do
    if lab[x] <> lab[y] then
      begin
        noO[lab[x]] := False;
        noI[lab[y]] := False;
      end;
end;

procedure InverseDirections;
var
  i: Integer;
  btemp: Boolean;
  itemp: Integer;
begin
  for i := 1 to m do with e[i] do
    begin
      itemp := x; x := y; y := itemp;
    end;
  BuildIncidentLists;
  for i := 1 to n do
    begin
      btemp := noI[i]; noI[i] := noO[i]; noO[i] := btemp;
    end;
end;

procedure AddEdge(u, v: Integer);
begin
  Inc(m);
  with e[m] do
    begin
      x := u; y := v;
      link := head[x]; head[x] := m;
    end;
  noI[v] := False;
  noO[u] := False;
end;

procedure AddMoreEdges;
var
  p, q, black, white, oldtop: Integer;

  procedure Visit(u: Integer);
  var
    i: Integer;
  begin
    if noO[u] then Push(u);
    num[u] := 1;
    i := head[u];
    while i <> 0 do with e[i] do
      begin
        if num[y] = 0 then Visit(y);
        i := link;
      end;
  end;

begin
  FillDWord(num[1], n, 0);
  top := 0;
  black := 0;
  for q := 1 to n do
    if noI[q] then
      begin
        oldtop := top;
        Visit(q);
        if black = 0 then black := q
        else
          if oldtop <> top then
            begin
              p := Pop;
              AddEdge(p, black);
              black := q;
            end;
      end;
  InverseDirections;
  FillDWord(num[1], n, 0);
  top := 0;
  white := 0;
  for q := 1 to n do
    if noI[q] then
      begin
        oldtop := top;
        Visit(q);
        if white = 0 then white := q
        else
          if oldtop <> top then
            begin
              p := Pop;
              AddEdge(p, white);
              white := q;
            end;
      end;
  if not noO[black] then black := stack[top];
  //white: NoIn den duoc moi dinh khac
  //black: NoOut moi dinh khac den duoc
  AddEdge(black, white);
  q := 0;
  for p := 1 to n do
    if noI[p] then
      begin
        Inc(q);
        while (q <= n) and not noO[q] do Inc(q);
        if q <= n then
          AddEdge(q, p);
      end;
  for q := 1 to n do
    begin
      if noI[q] then AddEdge(black, q);
      if noO[q] then AddEdge(q, white);
    end;
end;

procedure Solve;
var
  SCount, TCount, ACount: Integer;
  i: Integer;
begin
  BuildIncidentLists;
  FindSCCs;
  FindNoIO;
  SCount := 0; TCount := 0; ACount := 0;
  for i := 1 to n do
    begin
      if noI[i] then Inc(SCount);
      if noO[i] then Inc(TCount);
      if noI[i] and noO[i] then Inc(ACount);
    end;
  if (SCount = 1) and (TCount = 1) and (ACount = 1) then
    Exit;
  AddMoreEdges;
end;

procedure PrintResult;
var
  i: Integer;
begin
  WriteLn(fo, m - savem);
  for i := savem + 1 to m do with e[i] do
    WriteLn(fo, y, ' ', x);
end;

begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
  try
    Enter;
    Solve;
    PrintResult;
  finally
    CloseFile(fi); CloseFile(fo);
  end;
end.
