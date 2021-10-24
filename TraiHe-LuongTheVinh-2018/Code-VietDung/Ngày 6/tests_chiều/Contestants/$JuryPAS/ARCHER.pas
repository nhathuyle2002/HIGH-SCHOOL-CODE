{$MODE OBJFPC}
{$DEFINE RELEASE}
{$R-,Q-,S-,I-}
{$OPTIMIZATION LEVEL2}
{$INLINE ON}
program Marksman;
const
  InputFile  = 'ARCHER.INP';
  OutputFile = 'ARCHER.OUT';
  maxN = 2000;
  maxC = 2000;
  infty = High(QWord);
type
  TCoord = SmallInt;
  TCode = QWord;
  TVector = record
    x, y, z: Integer;
  end;
  TPoint = TVector;
var
  p: array[1..maxN] of TPoint;
  k: array[1..maxN] of TVector;
  n: Integer;
  res: Integer;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n);
    for i := 1 to n do
      with p[i] do ReadLn(f, x, y, z);
  finally
    CloseFile(f);
  end;
end;

procedure GetVector(const a, b: TPoint; var v: TVector); inline;
var
  d: TCoord;
begin
  with v do
    begin
      x := b.x - a.x;
      y := b.y - a.y;
      z := b.z - a.z;
      if z < 0 then
        begin
          x := -x; y := -y; z := -z;
        end;
    end;
end;

function Vector0(const v: TVector): Boolean; inline;
begin
  Result := (v.x = 0) and (v.y = 0) and (v.z = 0);
end;

function Less(const u, v: TVector): Boolean; inline;
var
  u0, v0: Boolean;
begin
  u0 := Vector0(u); v0 := Vector0(v);
  if u0 or v0 then
    Exit(u0 and not v0);
  //ux / uz < vx / vz hoac ux / uz = vx/vz va uy / uz < vy / vz
  Result := (u.x * v.z < u.z * v.x) or
            (u.x * v.z = u.z * v.x) and (u.y * v.z < u.z * v.y);
end;

function Equal(const u, v: TVector): Boolean; inline;
begin
  Result := (u.x * v.z = u.z * v.x) and (u.y * v.z = u.z * v.y);
end;

procedure ShellSort(nv: Integer);
var
  i, j, step: Integer;
  temp: TVector;
begin
  step := nv div 2;
  while step <> 0 do
    begin
      for i := step + 1 to nv do
        begin
          temp := k[i]; j := i - step;
          while (j > 0) and Less(temp, k[j]) do
            begin
              k[j + step] := k[j]; Dec(j, step);
            end;
          k[j + step] := temp;
        end;
      if step = 2 then step := 1
      else step := step * 10 div 22;
    end;
end;

procedure Solve;
var
  i, j: Integer;
  s, t: Integer;
  nv0: Integer;
begin
  res := 0;
  for i := n downto 2 do
    begin
      if i < res then Break;
      for j := i - 1 downto 1 do
        GetVector(p[i], p[j], k[j]);
      ShellSort(i - 1);
      s := 1;
      while (s < i) and Vector0(k[s]) do Inc(s); //Dem so vector 0
      nv0 := s - 1;
      if nv0 > res then res := nv0;
      while s < i do
        begin
          t := s + 1;
          while (t < i) and Equal(k[t], k[s]) do Inc(t);
          if (t - s + nv0 > res) and (k[s].z <> 0) then
            res := t - s + nv0;
          s := t;
        end;
    end;
  Inc(res);
end;

procedure PrintResult;
var
  f: TextFile;
begin
  AssignFile(f, OutputFile); Rewrite(f);
  try
    WriteLn(f, res);
  finally
    CloseFile(f);
  end;
end;

begin
  Enter;
  Solve;
  PrintResult;
end.
7
2 1 1
3 2 2
4 3 3
0 0 4
0 1 4
0 2 4
0 3 4
