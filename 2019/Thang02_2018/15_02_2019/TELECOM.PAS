{$MODE OBJFPC}
{$DEFINE RELEASE}
{$R-,Q-,S-,I-}
{$OPTIMIZATION LEVEL2}
{$INLINE ON}
program Telecom;
uses Math;
const
  InputFile  = 'TELECOM.INP';
  OutputFile = 'TELECOM.OUT';
  maxN = 200;
  maxC = 10000;
  epsilon = 1E-9;
type
  TPoint = packed record
  case Boolean of
    False: (x, y: LongInt);
    True: (Code: Int64);
  end;
  TVector = TPoint;
var
  n: Integer;
  p: array[1..maxN] of TPoint;
  q: array[1..maxN + 1] of TPoint;
  mark: array[2..maxN - 1] of Boolean;
  top: Integer;
  A, B, u: TPoint;
  res, finalres: Double;
  resX, resY, finalX, finalY: Double;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n);
    for i := 1 to n do
      with p[i] do
        ReadLn(f, x, y);
  finally
    CloseFile(f);
  end;
end;

operator <(const a, b: TPoint): Boolean; inline;
begin
  Result := (a.x < b.x) or (a.x = b.x) and (a.y < b.y);
end;

procedure Sort(L, H: Integer);
var
  pivot: TPoint;
  i, j: Integer;
begin
  if L >= H then Exit;
  i := L + Random(H - L + 1);
  pivot := p[i]; p[i] := p[L];
  i := L; j := H;
  repeat
    while (pivot < p[j]) and (i < j) do Dec(j);
    if i < j then
      begin
        p[i] := p[j]; Inc(i);
      end
    else Break;
    while (p[i] < pivot) and (i < j) do Inc(i);
    if i < j then
      begin
        p[j] := p[i]; Dec(j);
      end
    else Break;
  until i = j;
  p[i] := pivot;
  Sort(L, i - 1); Sort(i + 1, H);
end;

function Vector(const p, q: TPoint): TVector; inline;
begin
  Result.x := q.x - p.x;
  Result.y := q.y - p.y;
end;

function Distance(const u: TVector): Double; inline;
begin
  Result := Sqrt(Sqr(u.x) + Sqr(u.y));
end;

function CCW(const u, v: TVector): Integer; overload; inline;
begin
  Result := u.x * v.y - u.y * v.x;
end;

function CCW(const a, b, c: TPoint): Integer; overload; inline;
begin
  Result := CCW(vector(a, b), vector(b, c));
end;

operator *(const u, v: TVector): Double; inline;
begin
  Result := u.x * v.x + u.y * v.y;
end;

function Angle(const p, q, r: TPoint): Double;
var
  u, v: TVector;
  ccwres, sine: Double;
begin
  u := Vector(p, q);
  v := Vector(p, r);
  if (Distance(u) = 0) or (Distance(v) = 0) then
    Exit(0);
  ccwres := CCW(u, v);
  sine := EnsureRange(ccwres / (Distance(u) * Distance(v)), -1, 1);
  Result := ArcSin(sine);
  if u * v < 0 then
    if Result > 0 then Result := Pi - Result
    else Result := -Pi - Result;
end;

procedure Minimize(var target: Double; value: Double);
begin
  if target > value then target := value;
end;

function Check(i, j: Integer): Boolean;
var
  k, ia, ib: Integer;
  alpha, beta, gamma, phi, area2, height: Double;
  centerX, centerY: double;
  ab: TVector;
  sx, sy: Double;
  temp: Integer;
begin
  alpha := Pi;
  beta := Pi;
  for k := 1 to top do
    if (k <> i) and (k <> j) then
      begin
        phi := Angle(q[k], q[i], q[j]);
        if phi >= 0 then
          Minimize(alpha, phi)
        else
          Minimize(beta, -phi);
      end;
  if (alpha + beta < Pi - epsilon) then
    Exit(False);
  //alpha + beta >= pi
  if (alpha >= pi / 2) and (beta >= pi / 2) then
    begin
      res := Distance(vector(q[i], q[j])) / 2;
      resX := (q[i].x + q[j].x) / 2;
      resY := (q[i].y + q[j].y) / 2;
      Exit(True);
    end;
  if alpha < beta then
    gamma := 2 * alpha
  else
    gamma := 2 * beta;
  ab := Vector(q[i], q[j]);
  res := Distance(ab) / sin(gamma / 2) / 2;
  area2 := res * res * Sin(gamma);
  height := area2 / Distance(ab);
  centerx := (q[i].x + q[j].x) / 2;
  centery := (q[i].y + q[j].y) / 2;
  with ab do
    begin
      temp := x; x := -y; y := temp;
      if beta < alpha then
        x := -x; y := -y;
      sx := x / Distance(ab); sy := y / Distance(ab);
    end;
  resX := centerX + height * sx;
  resY := centerY + height * sy;
  Result := True;
end;

procedure Solve;
var
  i, j: Integer;
begin
  for i := 1 to n do
    p[i] := Vector(A, p[i]);
  u := p[n];
  for i := 2 to n - 1 do
    mark[i] := CCW(u, p[i]) >= 0;
  top := 1;
  q[1] := p[1];
  for i := 2 to n do
    if (i = n) or mark[i] then
      begin
        while (top >= 2) and (CCW(q[top - 1], q[top], p[i]) >= 0)
          do Dec(top);
        Inc(top);
        q[top] := p[i];
      end;
  for i := n - 1 downto 1 do
    if (i = 1) or not mark[i] then
      begin
        while (top >= 2) and (CCW(q[top - 1], q[top], p[i]) >= 0)
          do Dec(top);
        Inc(top);
        q[top] := p[i];
      end;
  if top = 2 then q[top] := p[n]
  else Dec(top);
  finalres := 2 * maxC;
  for i := 1 to top do
    for j := i + 1 to top do
      if Check(i, j) and (res < finalres) then
        begin
          finalres := res;
          finalX := resX;
          finalY := resY;
        end;
  finalX := finalX + A.x;
  finalY := finalY + A.y;
end;

procedure PrintResult;
var
  f: TextFile;
begin
  AssignFile(f, OutputFile); Rewrite(f);
  try
    if Abs(finalres) < epsilon then
      WriteLn(f, p[1].x + 0.0:0:6, ' ', p[1].y + 0.0:0:6, ' ', 0.0:0:6)
    else
      WriteLn(f, finalX:0:6, ' ', finalY:0:6, ' ', finalres:0:6);
  finally
    CloseFile(f);
  end;
end;

begin
  Enter;
  Sort(1, n);
  A := p[1]; B := p[n];
  if A.code = B.code then
    finalres := 0
  else
    Solve;
  PrintResult;
end.
