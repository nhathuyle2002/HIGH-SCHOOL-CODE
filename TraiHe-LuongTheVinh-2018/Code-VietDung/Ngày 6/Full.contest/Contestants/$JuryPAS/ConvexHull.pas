{$MODE OBJFPC}
{$DEFINE RELEASE}
{$R-,Q-,S-,I-}
{$OPTIMIZATION LEVEL2}
{$INLINE ON}
program ConvexHull;
const
  InputFile  = 'CONVEXHULL.INP';
  OutputFile = 'CONVEXHULL.OUT';
  maxN = Round(1E5);
type
  TPoint = record
    x, y: Int64;
  end;
  TVector = TPoint;
var
  p, q: array[1..maxN] of TPoint;
  stack: array[1..maxN] of Integer;
  top: Integer;
  base: TPoint;
  n: Integer;
  Area: Int64;
  resS: AnsiString;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n);
    for i := 1 to n do
      with p[i] do ReadLn(f, x, y);
  finally
    CloseFile(f);
  end;
end;

operator =(const u, v: TVector): Boolean; inline;
begin
  Result := (u.x = v.x) and (u.y = v.y);
end;

operator -(const u, v: TVector): TVector; inline;
begin
  Result.x := u.x - v.x;
  Result.y := u.y - v.y;
end;

operator ><(const u, v: TVector): Int64; inline; //CCW function
begin
  Result := u.x * v.y - u.y * v.x;
end;

procedure Sort(L, H: Integer);
var
  i, j: Integer;
  pivot: TPoint;
begin
  if L >= H then Exit;
  i := L + Random(H - L + 1);
  pivot := p[i]; p[i] := p[L];
  i := L; j := H;
  repeat
    while (pivot >< p[j] > 0) and (i < j) do Dec(j);
    if i < j then
      begin
        p[i] := p[j]; Inc(i);
      end
    else Break;
    while (pivot >< p[i] < 0) and (i < j) do Inc(i);
    if i < j then
      begin
        p[j] := p[i]; Dec(j);
      end
    else Break;
  until i = j;
  p[i] := pivot;
  Sort(L, i - 1); Sort(i + 1, H);
end;

procedure Init;
var
  imin, i, j: Integer;
begin
  imin := 1;
  for i := 2 to n do
    if (p[i].y < p[imin].y) or
       (p[i].y = p[imin].y) and (p[i].x < p[imin].x) then imin := i;
  base := p[imin]; j := 0;
  for i := 1 to n do
    if p[i] <> base then
      begin
        Inc(j); p[j] := p[i] - base;
      end;
  n := j + 1;
  p[n].x := 0; p[n].y := 0;
  Sort(1, n - 1);
end;

function Distance(const p: TPoint): Integer; inline; //manhatan distance
begin
  Result := Abs(p.x) + Abs(p.y);
end;

function TurnLeft(const a, b, c: TPoint): Boolean; inline;
begin
  Result := (b - a) >< (c - b) > 0;
end;

procedure Solve;
var
  i: Integer;
begin
  stack[1] := n; top := 1;
  for i := 1 to n - 1 do
    begin
      if (top > 1) and (p[i] >< p[stack[top]] = 0) then
        if Distance(p[i]) > Distance(p[stack[top]]) then
          Dec(top)
        else
          Continue;
      while (top > 1) and
        not TurnLeft(p[stack[top - 1]], p[stack[top]], p[i]) do Dec(top);
      Inc(top);
      stack[top] := i;
    end;
  Area := 0;
  for i := 3 to top do
    Area := Area + p[stack[i - 1]] >< p[stack[i]];
  Str(Area div 2, resS);
  if Odd(Area) then resS := resS + '.5'
  else resS := resS + '.0';
end;

procedure PrintResult;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, OutputFile); Rewrite(f);
  try
    WriteLn(f, top);
    WriteLn(f, resS);
    for i := 1 to top do
      with p[stack[i]] do
        WriteLn(f, x + base.x, ' ', y + base.y);
  finally
    CloseFile(f);
  end;
end;

begin
  Enter;
  Init;
  Solve;
  PrintResult;
end.
