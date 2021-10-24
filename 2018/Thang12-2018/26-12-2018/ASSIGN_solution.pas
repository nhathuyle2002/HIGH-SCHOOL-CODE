{$MODE OBJFPC}
program MaximumBipartiteMatching;
const
  InputFile  = 'ASSIGN.INP';
  OutputFile = 'ASSIGN.OUT';
  maxN = 100000;
  maxM = 100000;
var
  p, q: Integer;
  adj: array[1..maxM] of Integer;
  link: array[1..maxM] of Integer;
  head: array[1..maxN] of Integer;
  match: array[1..maxN] of Integer;
  lab: array[1..maxN] of Integer;
  avail: array[1..maxN] of Boolean;
  List: array[1..maxN] of Integer;
  nList: Integer;
  res: Integer;

procedure Enter;
var
  i: Integer;
  x, y: Integer;
  f: TextFile;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, p, q);
    FillChar(head[1], p * SizeOf(head[1]), 0);
    FillDWord(match[1], q, 0);
    FillDWord(lab[1], p, 0);
    i := 0;
    while not SeekEof(f) do
      begin
        Inc(i);
        ReadLn(f, x, y);
        adj[i] := y;
        link[i] := head[x]; head[x] := i;
        if (lab[x] = 0) and (match[y] = 0) then
          begin
            match[y] := x;
            lab[x] := y;
          end;
      end;
  finally
    CloseFile(f);
  end;
end;

procedure Init;
var
  i: Integer;
begin
  nList := 0;
  for i := 1 to p do
    if lab[i] = 0 then
      begin
        Inc(nList); List[nList] := i;
      end;
end;

procedure SuccessiveAugmentingPaths;
var
  Found: Boolean;
  Old, i: Integer;

  procedure Visit(x: Integer);
  var
    i: Integer;
    y: Integer;
  begin
    i := head[x];
    while i <> 0 do
      begin
        y := adj[i];
        if avail[y] then
          begin
            avail[y] := False;
            if match[y] = 0 then Found := True
            else Visit(match[y]);
            if Found then
              begin
                match[y] := x;
                Exit;
              end;
          end;
        i := link[i];
      end;
  end;

begin
  repeat
    Old := nList;
    FillChar(avail[1], q * SizeOf(avail[1]), True);
    for i := nList downto 1 do
      begin
        Found := False;
        Visit(List[i]);
        if Found then
          begin
            List[i] := List[nList];
            Dec(nList);
          end;
      end;
  until Old = nList;
  res := p - nList;
end;

procedure PrintResult;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, OutputFile); Rewrite(f);
  try
    WriteLn(f, res);
    for i := 1 to q do
      Write(f, match[i], ' ');
  finally
    CloseFile(f);
  end;
end;

begin
  Enter;
  Init;
  SuccessiveAugmentingPaths;
  PrintResult;
end.

4 3
1 1
1 3
2 1
2 2
3 2
4 1
