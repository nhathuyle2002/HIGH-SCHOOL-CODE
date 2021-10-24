{$MODE OBJFPC}
{$INLINE ON}
{$R-,Q-,S-,I-}
{$OPTIMIZATION LEVEL3}
{$DEFINE USEFILEIO} // remove this line in case of STD IO
program SmartDog;

const
{$IFDEF USEFILEIO}
  InputFile = 'SMARTDOG.INP';
  OutputFile = 'SMARTDOG.OUT';
{$ELSE} // use stdio
  InputFile = '';
  OutputFile = '';
{$ENDIF}
  maxN = Round(1E5);
  maxXY = 2 * Round(1E3) + 1;

type
  TPoint = record
    x, y, c: Integer;
  end;

  TRangeTree1DNode = record
    loc, glo: Integer;
  end;

  TRangeTree1D = array [1 .. maxXY] of TRangeTree1DNode;

  TRangeTree2DNode = packed record
    loc, glo: TRangeTree1D;
  end;

  TRangeTree2D = array [1 .. maxXY] of TRangeTree2DNode;

var
  P: array [0 .. maxN] of TPoint;
  key, pos, l, h: array [1 .. maxXY] of Integer;
  Tree: TRangeTree2D;
  n, k: Integer;
  res, range: Integer;

procedure Enter;
var
  f: TextFile;
  i: Integer;
  minX, minY: Integer;
begin
  AssignFile(f, InputFile);
  Reset(f);
  try
    ReadLn(f, n, k);
    P[0].x := 0;
    P[0].y := 0;
    minX := 0;
    minY := 0;
    for i := 1 to n do
      with P[i] do
        begin
          ReadLn(f, x, y, c);
          Inc(x, y);
          y := x - 2 * y;
          if x < minX then
            minX := x;
          if y < minY then
            minY := y;
        end;
    range := 0;
    for i := 0 to n do
      with P[i] do
        begin
          Dec(x, minX - 1);
          Dec(y, minY - 1);
          if x > range then range := x;
          if y > range then range := y;
        end;
  finally
    CloseFile(f);
  end;
end;

function Maximize(var target: Integer; value: Integer): Boolean; inline;
begin
  Result := target < value;
  if Result then target := value;
end;

procedure Init;
var
  count: Integer;

  procedure Build(x: Integer);
  begin
    if x > Range then  Exit;
    l[x] := count + 1;
    Build(x * 2);
    Inc(count); key[x] := count; pos[count] := x;
    Build(x * 2 + 1);
    h[x] := count;
  end;

begin
  count := 0;
  Build(1);
  FillChar(Tree, SizeOf(Tree), $FF);
end;

procedure UpdateY(var T: TRangeTree1D; y: Integer; f: Integer); inline;
var
  node: Integer;
begin
  node := pos[y];
  if not Maximize(T[node].loc, f) then
    Exit;
  repeat
    if not Maximize(T[node].glo, f) then
      Break;
    node := node shr 1;
  until node = 0;
end;

procedure UpdateXY(x, y: Integer; f: Integer); inline;
var
  node: Integer;
begin
  node := pos[x];
  UpdateY(Tree[node].loc, y, f);
  repeat
    UpdateY(Tree[node].glo, y, f);
    node := node shr 1;
  until node = 0;
end;

function QueryY(const T: TRangeTree1D; loy, hiy: Integer): Integer;

  function Request(node: Integer): Integer;
  begin
    if (node > Range) or (l[node] > hiy) or (h[node] < loy) then
      Exit(-1);
    if (l[node] >= loy) and (h[node] <= hiy) then
      Exit(T[node].glo);
    Result := Request(node shl 1);
    if (loy <= key[node]) and (key[node] <= hiy) then
      Maximize(Result, T[node].loc);
    Maximize(Result, Request(node shl 1 + 1));
  end;

begin
  Result := Request(1);
end;

function Query(lox, loy, hix, hiy: Integer): Integer;

  function Request(node: Integer): Integer;
  begin
    if (node > Range) or (l[node] > hix) or (h[node] < lox) then
      Exit(-1);
    if (l[node] >= lox) and (h[node] <= hix) then
      Exit(QueryY(Tree[node].glo, loy, hiy));
    Result := Request(node shl 1);
    if (lox <= key[node]) and (key[node] <= hix) then
      Maximize(Result, QueryY(Tree[node].loc, loy, hiy));
    Maximize(Result, Request(node shl 1 + 1));
  end;

begin
  Result := Request(1);
end;

procedure Optimize;
var
  i, j: Integer;
  f: Integer;
begin
  res := 0;
  with P[0] do
    UpdateXY(x, y, 0);
  for i := 1 to n do
    with P[i] do
      begin
        f := Query(x - k, y - k, x + k, y + k);
        if f >= 0 then
          begin
            UpdateXY(x, y, f + c);
            Maximize(res, f + c);
          end;
      end;
end;

procedure PrintResult;
var
  f: TextFile;
begin
  AssignFile(f, OutputFile);
  Rewrite(f);
  try
    write(f, res);
  finally
    CloseFile(f);
  end;
end;

begin
  Enter;
  Init;
  Optimize;
  PrintResult;
end.

