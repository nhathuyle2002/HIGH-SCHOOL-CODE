{$MODE OBJFPC}
program HashValue;
uses Math;
const
  InputFile  = 'HASH.INP';
  OutputFile = 'HASH.OUT';
  maxM = 2000;
  maxN = 5000;
  maxR = 32;
type
  TNumber = array[0..maxM - 1] of Integer;
  TNumberR = array[0..maxM - 1] of Extended;
  TIndex = array[1..maxN] of Integer;
  PIndex = ^TIndex;
var
  a: array[1..maxN] of TNumber;
  n, m, modulus: Integer;
  x, y: TIndex;
  p, q: PIndex;
  code: array[1..maxN] of Integer;
  res: Integer;

procedure StrToNumber(const s: AnsiString; var x: TNumber);
var
  i: Integer;
begin
  for i := Length(s) downto 1 do
    x[Length(s) - i] := Ord(s[i]) - Ord('0');
  FillDWord(x[Length(s)], maxM - Length(s), 0);
end;

function Check(const x, y: TNumber; r, s: Integer): Boolean;
const
  hm = 1234567;
var
  i: Integer;
  r1, r2: Integer;
begin
  r1 := 0; r2 := 0;
  for i := maxM - 1 downto 0 do
    begin
      r1 := (r1 * r + x[i]) mod hm;
      r2 := (r2 * s + y[i]) mod hm;
    end;
  Result := r1 = r2;
  if not Result then
    WriteLn(r1, ' ', r2);
end;

procedure Convert(const x: TNumber; var y: TNumber; r, s: Integer);
var
  d, k: Integer;
  pow, logsr: Extended;
  rnum: TNumberR;
  ipart, fpart: Extended;
begin
  FillChar(rnum, SizeOf(rnum), 0);
  logsr := logn(s, r);
  for d := maxM - 1 downto 0 do
    if x[d] <> 0 then
      begin
        pow := d * logsr;
        k := Trunc(pow);
        rnum[k] := rnum[k] + x[d] * Power(s, pow - k);
      end;
  for d := maxM - 1 downto 0 do
    begin
      ipart := Int(rnum[d]);
      fpart := rnum[d] - ipart;
      y[d] := Round(ipart);
      if d > 0 then
        rnum[d - 1] := rnum[d - 1] + fpart * s
      else //d = 0
        if fpart > 0.5 then Inc(y[d]);
    end;
  for d := 0 to maxM - 2 do
    begin
      Inc(y[d + 1], y[d] div s);
      y[d] := y[d] mod s;
    end;
  if not Check(x, y, r, s) then
    begin
      k := maxM - 1;
      while (k >= 0) and (x[k] = 0) do Dec(k);
      WriteLn(k);
    end;
end;

procedure Enter;
var
  f: TextFile;
  s: AnsiString;
  temp: TNumber;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n, modulus);
    Inc(modulus);
    for i := 1 to n do
      begin
        ReadLn(f, s);
        StrToNumber(s, temp);
        Convert(temp, a[i], 10, modulus);
      end;
  finally
    CloseFile(f);
  end;
end;

procedure Init2;
var
  i: Integer;
begin
  FillDWord(code[1], n, 0);
  for i := 1 to n do
    x[i] := i;
end;

function Solve: Integer;
var
  i, j, i1: Integer;
  count: array[0..maxR - 1] of Integer;
  c: Integer;
  prev, k: Integer;
  r: PIndex;
begin
  p := @x; q := @y;
  for j := 0 to maxM - 1 do
    begin
      FillChar(count, SizeOf(count), 0);
      for i := 1 to n do
        Inc(count[a[i, j]]);
      for c := 1 to modulus - 1 do
        Inc(count[c], count[pred(c)]);
      for i := n downto 1 do
        begin
          c := a[p^[i], j];
          q^[count[c]] := p^[i];
          Dec(count[c]);
        end;
      prev := -1; c := -1; k := 0;
      for i := 1 to n do
        begin
          i1 := q^[i];
          if (a[i1, j] <> c) or (code[i1] <> prev) then
            begin
              c := a[i1, j]; prev := code[i1];
              Inc(k);
            end;
          code[i1] := k;
        end;
      if k = n then Exit(j + 1);
      r := p; p := q; q := r;
    end;
  Result := 0;
end;

procedure PrintResult;
var
  f: TextFile;
begin
  AssignFile(f, OutputFile); Rewrite(f);
  try
    Write(f, res);
  finally
    CloseFile(f);
  end;
end;

begin
  Enter;
  Init2;
  res := Solve;
  PrintResult;
end.
4 2
65
40
20
37
