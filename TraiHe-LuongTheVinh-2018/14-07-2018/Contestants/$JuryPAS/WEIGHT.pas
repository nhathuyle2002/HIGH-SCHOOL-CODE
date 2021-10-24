{$MODE OBJFPC}
program COCI6;
const
  InputFile  = 'WEIGHT.INP';
  OutputFile = 'WEIGHT.OUT';
  maxN = Round(1E6);
type
  TStack = record
    items: array[1..maxN] of Integer;
    top: Integer;
  end;
  TArr = array[1..maxN] of Integer;
var
  a: array[1..maxN] of Integer;
  lmax, rmax, lmin, rmin: TArr;
  stack: TStack;
  n: Integer;
  res: Int64;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n);
    for i := 1 to n do Read(f, a[i]);
  finally
    CloseFile(f);
  end;
end;

procedure GetLR(var left, right: TArr);
var i: Integer;
begin
  with stack do
    begin
      top := 0;
      for i := 1 to n do
        begin
          while (top > 0) and (a[items[top]] < a[i]) do
            Dec(top);
          if top > 0 then left[i] := items[top]
          else left[i] := 0;
          Inc(top); items[top] := i;
        end;
      top := 0;
      for i := n downto 1 do
        begin
          while (top > 0) and (a[items[top]] <= a[i]) do
            Dec(top);
          if top > 0 then right[i] := items[top]
          else right[i] := n + 1;
          Inc(top); items[top] := i;
        end;
    end;
end;

function nSegs(L, R, p: Integer): Int64;
begin
  Result := Int64(p - L) * (R - p);
end;

procedure Solve;
var
  i: Integer;
  t: Int64;
begin
  GetLR(lmax, rmax);
  for i := 1 to n do a[i] := -a[i];
  GetLR(lmin, rmin);
  res := 0;
  for i := 1 to n do
    begin
      t := nSegs(lmax[i], rmax[i], i);
      res := res - a[i] * t;
      t := nSegs(lmin[i], rmin[i], i);
      res := res + a[i] * t;
    end;
end;

procedure Print;
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
  Print;
end.
