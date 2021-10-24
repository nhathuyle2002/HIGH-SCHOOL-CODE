{$MODE OBJFPC}
program SequenceCounting;
const
  InputFile  = 'SEQCOUNT.INP';
  OutputFile = 'SEQCOUNT.OUT';
  modulo = 1234567890;
  p: array[1..5] of Integer = (2, 3, 5, 3607, 3803);
  e: array[1..5] of Integer = (1, 2, 1, 1, 1);
var
  fi, fo: TextFile;
  n, m: Int64;

procedure Analysis(k: Int64);
var
  p, e: Int64;
begin
  p := 2;
  while k <> 1 do
    begin
      e := 0;
      while k mod p = 0 do
        begin
          Inc(e);
          k := k div p;
        end;
      if e <> 0 then
        WriteLn(p, '^', e);
      Inc(p);
      if (k > 1) and (p * p > k) then p := k;
    end;
end;

function Inverse(a, m: Int64): Int64; //GCD(a, m) = 1; return a^-1 mod m
var
  xa, xm, xr, r, q: Int64;
begin
  xa := 1;
  xm := 0;
  while m <> 0 do
    begin
      q := a div m;
      r := a - q * m; a := m; m := r;
      xr := xa - q * xm; xa := xm; xm := xr;
    end;
  Result := xa;
end;

function IntPower(p, k: Int64): Int64; //p^k
begin
  if k = 0 then Exit(1);
  Result := Sqr(IntPower(p, k div 2));
  if Odd(k) then Result := Result * p;
end;

function IntPowerMod(p, k, m: Int64): Int64; //p^k mod m
begin
  if k = 0 then Exit(1 mod m);
  Result := Sqr(IntPowerMod(p, k div 2, m)) mod m;
  if Odd(k) then Result := Result * p mod m;
end;

{p: So nguyen to, e so mu
Tinh xem n! chua bao nhieu luy thua cua p: power
Va neu bo het cac thua so p trong khai trien n!,
so du cua no khi chia cho p^e bang bao nhieu: remainder}
procedure FactorialAnalysis(n, p, e: Int64; var power, remainder: Int64);
var
  i, j: Integer;
  temp, pe: Int64;
begin
  //Tinh power
  temp := n;
  power := 0;
  while temp > 0 do
    begin
      temp := temp div p;
      Inc(power, temp);
    end;

  //Tinh remainder
  remainder := 1;
  pe := IntPower(p, e);
  while n > 0 do
    begin
      temp := 1;
      for i := 1 to pe do
        if i mod p <> 0 then temp := temp * i mod pe;
      remainder := remainder * IntPowerMod(temp, n div pe, pe) mod pe;
      for i := 1 to n mod pe do
        if i mod p <> 0 then remainder := remainder * i mod pe;
      n := n div p;
    end;
end;

//Cal C(k, n) mod (p^e)
function GetRemainder(n, k: Int64; p, e: Int64): Int64;
var
  r1, p1, r2, p2, r3, p3, modulo: Int64;
begin
  FactorialAnalysis(n, p, e, p1, r1);
  FactorialAnalysis(k, p, e, p2, r2);
  FactorialAnalysis(n - k, p, e, p3, r3);
  modulo := IntPower(p, e);
  Result := r1 * IntPowerMod(p, p1 - p2 - p3, modulo) mod modulo;
  Result := Result * Inverse(r2, modulo) mod modulo;
  Result := Result * Inverse(r3, modulo) mod modulo;
  Result := (Result + modulo) mod modulo;
end;

//C(k, n) mod modulo
function Solve(n, k: Int64): Int64;
var
  a, m, c, y: Int64;
  i: Integer;
begin
  Result := 0;
  for i := 1 to 5 do
    begin
      a := GetRemainder(n, k, p[i], e[i]);
      m := IntPower(p[i], e[i]);
      c := modulo div m;
      //chinese remainder theorem
      Result := (Result +
                 a *
                 c mod Modulo *
                 Inverse(c, m) mod modulo) mod Modulo;
    end;
  Result := (Result + Modulo) mod Modulo;
end;

procedure SolveAll;
var
  iTest, nTests: Integer;
begin
  ReadLn(fi, nTests);
  for iTest := 1 to nTests do
    begin
      ReadLn(fi, m, n);
      WriteLn(fo, Solve(m + n - 1, m));
    end;
end;

begin
  {Analysis(1234567890);
  Halt;}

  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
  try
    SolveAll;
  finally
    CloseFile(fi); CloseFile(fo);
  end;
end.

{
For testing only
function Fac(n: Int64): Int64;
var
  i: Integer;
begin
  Result := 1;
  for i := 1 to n do Result := Result * i;
end;

function C(n, k: Int64): Int64;
var
  i: Integer;
begin
  Result := 1;
  for i := 1 to k do
    Result := Result * (n - i + 1) div i;
end;

}
