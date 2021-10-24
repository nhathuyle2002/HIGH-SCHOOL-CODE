{$MODE OBJFPC}
program Task;
const
  InputFile  = 'INTSLE.INP';
  OutputFile = 'INTSLE.OUT';
  sNoSol = 'NO SOLUTION';
var
  fi, fo: TextFile;
  a1, b1, c1, a2, b2, c2: Int64;
  d, dx, dy: Int64;

function GCD(a, b: Int64): Int64;
var
  r: Int64;
begin
  while b <> 0 do
    begin
      r := a mod b; a := b; b := r;
    end;
  Result := Abs(a);
end;

procedure Solve;
var
  sol1, sol2: Boolean;
begin
  d := a1 * b2 - a2 * b1;
  dx := c1 * b2 - c2 * b1;
  dy := a1 * c2 - a2 * c1;
  if d <> 0 then
    begin
      if (dx mod d = 0) and (dy mod d = 0) then
        WriteLn(fo, dx div d, ' ', dy div d)
      else
        WriteLn(fo, sNoSol);
    end
  else
    if (dx <> 0) or (dy <> 0) then
      WriteLn(fo, sNoSol)
    else //d = dx = dy = 0, infinite solutions iff ONE solution exists.
      begin
        if (a1 = 0) and (b1 = 0) then
          sol1 := c1 = 0
        else
          sol1 :=  c1 mod GCD(a1, b1) = 0;
        if (a2 = 0) and (b2 = 0) then
          sol2 := c2 = 0
        else
          sol2 := c2 mod GCD(a2, b2) = 0;
        if sol1 and sol2 then WriteLn(fo, 'INFINITE')
        else WriteLn(fo, sNoSol);
      end;
end;

procedure SolveAll;
var
  n, i: Integer;
begin
  ReadLn(fi, n);
  for i := 1 to n do
    begin
      ReadLn(fi, a1, b1, c1, a2, b2, c2);
      Solve;
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

