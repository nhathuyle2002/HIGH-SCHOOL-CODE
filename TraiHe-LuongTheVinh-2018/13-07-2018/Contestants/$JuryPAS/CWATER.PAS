{$MODE OBJFPC}
program ElimitingWater;
const
  InputFile  = 'CWATER.INP';
  OutputFile = 'CWATER.OUT';
var
  fi, fo: TextFile;
  a, b, c, d, x, y, res: Int64;

procedure Solve;
var
  m, n, r, q, xm, xn, xr, t: Integer;
begin
  if a < b then
    begin
      t := a; a := b; b := t;
    end;
  m := a; xm := 1;
  n := b; xn := 0;
  while n <> 0 do
    begin
      q := m div n;
      r := m mod n;
      xr := xm - q * xn;
      m := n; xm := xn;
      n := r; xn := xr;
    end;
  d := m;
  x := xm;
  y := (d - a * xm) div b;
end;

procedure Eliminate;
var
  t: Int64;
  ap, bp, cp: Int64;
begin
  if c mod d <> 0 then
    begin
      res := -1;
      Exit;
    end;
  ap := a div d; bp := b div d; cp := c div d;
  x := x * cp; y := y * cp;
  //ax + by = c, a(x + bp) + b(y - ap) = c, ...
  y := (y mod ap + ap) mod ap;
  x := (c - b * y) div a;
  //ax + by = c, y >= 0;
  if (Abs(x) + Abs(y)) < Abs(x + bp) + Abs(y - ap) then
    res := Abs(x) + Abs(y)
  else
    res := Abs(x + bp) + Abs(y - ap);
end;

procedure SolveAll;
var
  ntest, itest: Integer;
begin
  ReadLn(fi, ntest);
  for itest := 1 to ntest do
    begin
      ReadLn(fi, a, b, c);
      Solve;
      Eliminate;
      WriteLn(fo, res);
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
