{$MODE OBJFPC}
program DIGIT;
const
  InputFile  = 'DIGIT.INP';
  OutputFile = 'DIGIT.OUT';
  nbit = 32;
  radix = QWord(1) shl nbit;
  mask = radix - 1;
  maxd = 3;
type
  TNumber = array[0..maxd] of Int64;
var
  a, b, k: QWord;
  res: Integer;

procedure Enter;
var
  f: TextFile;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, a, b, k);
  finally
    CloseFile(f);
  end;
end;

function MulMod(x, y, z: QWord): QWord; //x * y mod z
var
  temp: QWord;
begin
  if y = 0 then Exit(0);
  temp := MulMod(x, y shr 1, z);
  Result := temp shl 1 mod z;
  if Odd(y) then
    Result := (Result + x) mod z;
end;

function Power10(n, z: QWord): QWord; //10^n mod z
var
  temp: QWord;
begin
  if n = 0 then Result := 1 mod z
  else
    begin
      temp := Power10(n shr 1, z);
      Result := MulMod(temp, temp, z);
      if Odd(n) then Result := Result * 10 mod z;
    end;
end;

procedure Solve;
begin
  res := MulMod(a, Power10(k - 1, b), b) * 10 div b;
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
  Solve;
  PrintResult;
end.
