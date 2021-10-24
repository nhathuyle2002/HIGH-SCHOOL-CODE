{$MODE OBJFPC}
{$IFNDEF DEBUG}
{$R-,Q-,S-,I-}
{$OPTIMIZATION LEVEL2}
{$INLINE ON}
{$ELSE}
{$INLINE OFF}
{$ENDIF}
program Task;
const
  InputFile  = 'WATERMOV.INP';
  OutputFile = 'WATERMOV.OUT';
  maxN = Round(1E6);
type
  TVector = record
    x, y: Int64;
  end;
  TPoint = TVector;
var
  fi, fo: TextFile;
  a: array[1..maxN] of Integer;
  b: array[0..maxN] of Int64;
  stack: array[1..maxN + 1] of TPoint;
  n, top: Integer;

procedure Enter;
var
  i: Integer;
begin
  ReadLn(fi, n);
  b[0] := 0;
  for i := 1 to n do
    begin
      Read(fi, a[i]);
      b[i] := b[Pred(i)] + a[i];
    end;
end;

function Point(x, y: Int64): TPoint; inline;
begin
  Result.x := x; Result.y := y;
end;

operator -(const u, v: TVector): TVector; inline;
begin
  Result.x := u.x - v.x;
  Result.y := u.y - v.y;
end;

operator ><(const u, v: TVector): Int64; inline;
begin
  Result := u.x * v.y - u.y * v.x;
end;

function CCW(const a, b, c: TPoint): Boolean; inline;
begin
  Result := (b - a) >< (c - b) > 0;
end;

procedure Solve;
var
  i: Integer;
  p: TPoint;
begin
  top := 1; stack[1] := Point(0, 0);
  for i := 1 to n do
    begin
      P := Point(i, b[i]);
      while (top > 1) and not CCW(stack[top - 1], stack[top], P) do
        Dec(top);
      Inc(top); stack[top] := P;
    end;
end;

procedure CalCost;
var
  i: Integer;
  res, res1, res2: Int64;
  p, q: TPoint;
begin
  res1 := 0;
  for i := 1 to n do
    Inc(res1, b[i] + b[i - 1]);
  res2 := 0;
  for i := 1 to top - 1 do
    begin
      p := stack[i]; q := stack[i + 1];
      Inc(res2, (p.y + q.y) * (q.x - p.x));
    end;
  res := res1 - res2;
  if res mod 2 = 0 then Write(fo, res div 2, '.0')
  else Write(fo, res div 2, '.5');
end;

begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
  try
    Enter;
    Solve;
    CalCost;
  finally
    CloseFile(fi); CloseFile(fo);
  end;
end.

