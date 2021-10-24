{$MODE OBJFPC}
program CountMod;
const
  InputFile  = 'COUNTMOD.INP';
  OutputFile = 'COUNTMOD.OUT';
var
  fi, fo: TextFile;
  a, b: array[1..4] of Int64;

procedure Enter;
var
  i: Integer;
begin
  for i := 1 to 4 do
    ReadLn(fi, a[i], b[i]);
end;

function DoMulMod(a, b, m: Int64): Int64;
var
  t: Int64;
begin
  if b = 0 then Exit(0);
  t := DoMulMod(a, b div 5, m) mod m;
  Result := (5 * t + (b mod 5) * a) mod m;
end;

function MulMod(a, b, m: Int64): Int64;
begin
  if b < 0 then
    begin
      a := -a; b := -b;
    end;
  Result := DoMulMod(a, b, m);
end;

function SolveDiophante(a, b, c: Int64; var lcm, x: Int64): Boolean;
var
  m, n, r, q, xm, xn, xr, t: Int64;
begin
  m := a; xm := 1;
  n := b; xn := 0;
  while n <> 0 do
    begin
      q := m div n;
      r := m - q * n;
      xr := xm - q * xn;
      m := n; xm := xn;
      n := r; xn := xr;
    end;
  Result := c mod m = 0;
  if not Result then Exit;
  t := c div m;
  x := MulMod(xm, t, b div m);
  lcm := Abs(a div m * b);
end;

//x mod a = b; x mod c = d

function SolveSE(a, b, c, d: int64; var m, x: Int64): Boolean;
var
  y: Int64;
begin
  Result := SolveDiophante(a, -c, d - b, m, y);
  if not Result then Exit;
  x := (MulMod(a, y, m) + b) mod m;
end;

function Solve4: Int64;
var
  a12, b12, a34, b34: Int64;
  x, m: Int64;
begin
  if not SolveSE(a[1], b[1], a[2], b[2], a12, b12) then Exit(-1);
  if not SolveSE(a[3], b[3], a[4], b[4], a34, b34) then Exit(-1);
  if not SolveSE(a12, b12, a34, b34, m, x) then Exit(-1);
  Result := ((x mod m) + m) mod m;
end;

procedure SolveAll;
var
  T, i: Integer;
begin
  ReadLn(fi, T);
  for i := 1 to T do
    begin
      Enter;
      WriteLn(fo, Solve4);
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

