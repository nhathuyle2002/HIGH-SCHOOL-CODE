{$MODE OBJFPC}
{$IFNDEF HOANG}
{$DEFINE RELEASE}
{$R-,Q-,S-,I-,D-}
{$OPTIMIZATION LEVEL3}
{$INLINE ON}
{$ENDIF}
program COCITasks;
const
  InputFile  = 'readers.inp';
  OutputFile = 'readers.out';
  maxN = Round(1E5);
  maxM = Round(1E5);
type
  TPoint = record
    x, y: Int64;
  end;
  TVector = TPoint;
var
  fi, fo: TextFile;
  t: array[0..maxN] of Int64;
  p: array[1..maxN] of TPoint;
  chull: array[1..maxN + 1] of TPoint;
  edge: array[1..maxN + 1] of TVector;
  top: Integer;
  n, m: Integer;
  res: Int64;

procedure OpenFiles;
begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
end;

procedure CloseFiles;
begin
  CloseFile(fi); CloseFile(fo);
end;

function Point(x, y: Int64): TPoint; inline;
begin
  Result.x := x; Result.y := y;
end;

operator - (const u, v: TVector): TVector; inline;
begin
  Result.x := u.x - v.x;
  Result.y := u.y - v.y;
end;

operator >< (const u, v: TVector): Int64; inline;
begin
  Result := u.x * v.y - u.y * v.x;
end;

function CCW(const a, b, c: TPoint): Int64; inline;
begin
  Result := (b - a) >< (c - a);
end;

procedure Enter;
var
  i: Integer;
begin
  ReadLn(fi, n, m);
  t[0] := 0;
  for i := 1 to n do
    begin
      Read(fi, t[i]);
      Inc(t[i], t[i - 1]);
    end;
  ReadLn(fi);
  for i := 1 to n do
    p[i] := Point(t[Pred(i)], t[i]);
end;

procedure BuildConvexHull;
var
  i: Integer;
begin
  top := 1;
  chull[1] := Point(0, 0);
  for i := 1 to n do
    begin
      while (top >= 2) and (CCW(chull[Pred(top)], chull[top], p[i]) >= 0) do
        Dec(top);
      Inc(top);
      chull[top] := p[i];
    end;
  for i := 1 to top - 1 do
    edge[i] := chull[Succ(i)] - chull[i];
end;

function BinarySearch(f, g: Integer): Int64; inline;
var
  std: TVector;
  low, middle, high: Integer;
begin
  std := Point(f, g);
  low := 2; high := top - 1;
  while low <= high do //(low - 1) >< std <= 0; (high + 1) >< std > 0
    begin
      middle := (low + high) shr 1;
      if edge[middle] >< std <= 0 then
        low := Succ(middle)
      else
        high := Pred(middle);
    end;
  Result := std >< chull[low];
end;

procedure Solve;
var
  i: Integer;
  f, g: Integer;
  delay: Int64;
begin
  f := 0;
  delay := 0;
  for i := 1 to m do
    begin
      Read(fi, g);
      Inc(delay, BinarySearch(f, g));
      f := g;
    end;
  res := delay + Int64(t[n]) * f;
  WriteLn(fo, res);
end;

begin
  OpenFiles;
  try
    Enter;
    BuildConvexHull;
    Solve;
  finally
    CloseFiles;
  end;
end.
