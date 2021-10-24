{$MODE OBJFPC}
program Task;
const
  InputFile  = 'PAPERS.INP';
  OutputFile = 'PAPERS.OUT';
  modulo = Round(1E9 + 7);
var
  fi, fo: TextFile;
  n, k, a, i: Integer;

function Inverse(a: Integer): Integer;
var
  m, r, q, xa, xm, xr: Integer;
begin
  m := modulo;
  xa := 1; xm := 0;
  while m <> 0 do
    begin
      q := a div m;
      xr := xa - q * xm;
      xa := xm; xm := xr;
      r := a mod m; a := m; m := r;
    end;
  Result := (xa + modulo) mod modulo;
end;

function C(k, n: Integer): Int64;
var
  i: Integer;
begin
  Result := 1;
  for i := 2 to k do Result := Result * i mod modulo;
  Result := Inverse(Result);
  for i := n downto n - k + 1 do Result := Result * i mod modulo;
end;

begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
  try
    ReadLn(fi, n, k);
    for i := 1 to k do
      begin
        Read(fi, a);
        n := n - a + 1;
        if n < 0 then n := -1;
      end;
    if k > n then WriteLn(fo, 0)
    else WriteLn(fo, C(k - 1, n - 1));
  finally
    CloseFile(fi); CloseFile(fo);
  end;
end.

