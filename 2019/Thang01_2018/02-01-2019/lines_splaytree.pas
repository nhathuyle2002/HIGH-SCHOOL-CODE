{$MODE OBJFPC}
{$R-,Q-,S-,I-}
{$OPTIMIZATION LEVEL3}
{$INLINE ON}
program _PROBLEM_Testing;
uses SysUtils, Math, JudgerV2;
const
  TimeLimit = 30.0; //Seconds
  ProblemTitle = 'LINES'; //Title bar
  Prefix = 'LINES'; //file name without extension
  ExeName = Prefix + '.EXE';
  TestCases: Ansistring = '1234567890abcdefghijklmnopqrstuvwxyz';
  InputFormat = Prefix + '._%s';
  InputFile  = Prefix + '.INP';
  OutputFile = Prefix + '.OUT';

  maxN = Round(1E5);
type
  TPoint = packed record
    x, y: LongInt;
  end;
  TVector = TPoint;
  PNode = ^TNode;
  TLine = packed record
    ptr: PNode;
    case Boolean of
      False: (x1, y1, x2, y2: LongInt);
      True: (eP, eQ: TPoint);
  end;
  TEndPoint = record
    x, y: Integer;
    close: Boolean;
    lineid: Integer;
  end;
  TNode = record
    lineid: Integer;
    P, L, R: PNode;
  end;
var
  lines: array[1..maxN] of TLine;
  p: array[1..2 * maxN] of TEndPoint;
  n: Integer;
  res: Integer;
  root, nilT: PNode;
  sentinel: TNode;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n);
    for i := 1 to n do
      with lines[i] do
        ReadLn(f, x1, y1, x2, y2);
  finally
    CloseFile(f);
  end;
end;

operator <(const p, q: TEndPoint): Boolean;
begin
  if p.x < q.x then Exit(True);
  if p.x > q.x then Exit(False);
  if p.close < q.close then Exit(True);
  if p.close > q.close then Exit(False);
  Result := p.y < q.y
end;

procedure SortPoints(L, H: Integer);
var
  pivot: TEndPoint;
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
  SortPoints(L, i - 1);
  SortPoints(i + 1, H);
end;

procedure Refine;
var
  i, j: Integer;

  procedure Swap(var a, b: Integer);
  var
    t: Integer;
  begin
    t := a; a := b; b := t;
  end;

begin
  for i := 1 to n do
    with lines[i] do
      if x1 > x2 then
        begin
          Swap(x1, x2); Swap(y1, y2);
        end;
  j := 2 * n;
  for i := 1 to n do
    with lines[i] do
      begin
        p[i].x := x1; p[i].y := y1;
        p[i].close := False;
        p[i].lineid := i;
        p[j].x := x2; p[j].y := y2;
        p[j].close := True;
        p[j].lineid := i;
        Dec(j);
      end;
  SortPoints(1, 2 * n);
end;

function Sign(x: Int64): Integer; inline;
begin
  if x > 0 then Result := 1
  else
    if x < 0 then Result := -1
    else Result := 0;
end;

operator -(const u, v: TVector): TVector; inline;
begin
  Result.x := u.x - v.x;
  Result.y := u.y - v.y;
end;

operator *(const u, v: TVector): Int64; //inline;
begin
  Result := Int64(u.x) * v.x + Int64(u.y) * v.y;end;

operator ><(const u, v: TVector): Integer; //inline;
begin
  Result := Sign(Int64(u.x) * v.y - Int64(u.y) * v.x);
end;

function Intersect(const a, b: TLine): Boolean; //inline
var
  d1, d2, d3, d4: Integer;

  function OnSeg(const M, N, P: TPoint): Boolean; inline;
  begin
    Result := Sign((M - P) * (N - P)) <= 0;
  end;

  function Dir(const M, N, P: TPoint): Integer; inline;
  begin
    Result := (N - M) >< (P - N);
    if (Result = 0) and OnSeg(M, N, P) then
      Result := 2;
  end;

begin
  d1 := Dir(b.eP, b.eQ, a.eP);
  if d1 = 2 then Exit(True);
  d2 := Dir(b.eP, b.eQ, a.eQ);
  if d2 = 2 then Exit(True);
  d3 := Dir(a.eP, a.eQ, b.eP);
  if d3 = 2 then Exit(True);
  d4 := Dir(a.eP, a.eQ, b.eQ);
  if d4 = 2 then Exit(True);
  Result := (d1 * d2 = -1) and (d3 * d4 = -1);
end;

procedure InitTree;
begin
  nilT := @sentinel;
  root := nilT;
end;

procedure DeleteTree(x: PNode);
begin
  if x = nilT then Exit;
  DeleteTree(x^.L);
  DeleteTree(x^.R);
  Dispose(x);
end;

procedure SetR(x, y: PNode); //inline;
begin
  x^.R := y; y^.P := x;
end;

procedure SetL(x, y: PNode); //inline;
begin
  x^.L := y; y^.P := x;
end;

procedure SetC(x, y: PNode; InRight: Boolean); //inline;
begin
  if InRight then SetR(x, y) else SetL(x, y);
end;

procedure UpTree(x: PNode); //inline;
var
  y, z: PNode;
begin
  y := x^.P; z := y^.P;
  if x = y^.L then
    begin
      SetL(y, x^.R); SetR(x, y);
    end
  else
    begin
      SetR(y, x^.L); SetL(x, y);
    end;
  SetC(z, x, z^.R = y);
end;

procedure Splay(x: PNode); //inline;
var
  y, z: PNode;
begin
  repeat
    y := x^.P;
    if y = nilT then Break;
    z := y^.P;
    if z <> nilT then
      if (y = z^.L) = (x = y^.L) then UpTree(y)
      else UpTree(x);
    UpTree(x);
  until False;
  root := x;
end;

function Predecessor(x: PNode): PNode; //inline;
begin
  Splay(x);
  if x^.L <> nilT then
    begin
      Result := x^.L;
      while Result^.R <> nilT do Result := Result^.R;
      Splay(Result);
    end
  else
    Result := nilT;
end;

function Successor(x: PNode): PNode; //inline;
begin
  Splay(x);
  if x^.R <> nilT then
    begin
      Result := x^.R;
      while Result^.L <> nilT do Result := Result^.L;
      Splay(Result);
    end
  else
    Result := nilT;
end;

function Above(const a, b: TLine): Boolean; //inline;
begin
  Result := (b.eP - a.eP) >< (b.eQ - a.eP) > 0;
end;

procedure Insert(lid: Integer); //inline;
var
  x, y: PNode;
  tr: Boolean;
begin
  x := nilT; y := root;
  while y <> nilT do
    begin
      x := y;
      tr := Above(lines[lid], lines[y^.lineid]);
      if tr then y := y^.R else y := y^.L;
    end;
  New(y);
  y^.lineid := lid; y^.L := nilT; y^.R := nilT;
  lines[lid].ptr := y;
  SetC(x, y, tr);
  Splay(y);
end;

procedure Delete(lid: Integer); //inline;
var
  x, y, z: PNode;
begin
  x := lines[lid].ptr;
  y := Predecessor(x);
  if y <> nilT then Splay(y);
  z := x^.P;
  if x^.L <> nilT then y := x^.L else y := x^.R;
  SetC(z, y, z^.R = x);
  if x = root then root := y;
  Dispose(x);
end;

function Upper(lineid: Integer): Integer; //inline;
var
  x: PNode;
begin
  x := lines[lineid].ptr;
  x := Successor(x);
  if x = nilT then Result := -1
  else Result := x^.lineid;
end;

function Lower(lineid: Integer): Integer; //inline;
var
  x: PNode;
begin
  x := lines[lineid].ptr;
  x := Predecessor(x);
  if x = nilT then Result := -1
  else Result := x^.lineid;
end;

function Check(threshold: Integer): Boolean;
var
  i: Integer;
  current: Integer;
  upperline, lowerline: Integer;
begin
  InitTree;
  try
    for i := 1 to 2 * n do
      if p[i].lineid <= threshold then
        if not p[i].close then
          begin
            current := p[i].lineid;
            Insert(current);
            upperline := Upper(current);
            if (upperline <> - 1) and
              Intersect(lines[current], lines[upperline]) then
              Exit(True);
            lowerline := Lower(current);
            if (lowerline <> -1) and
              Intersect(lines[current], lines[lowerline]) then
              Exit(True);
          end
       else
         begin
           current := p[i].lineid;
           upperline := Upper(current);
           lowerline := Lower(current);
           if (upperline <> -1) and (lowerline <> -1) and
             Intersect(lines[upperline], lines[lowerline]) then
               Exit(True);
           Delete(current);
         end;
    Result := False;
  finally
    DeleteTree(root);
  end;
end;

procedure Solve;
var
  low, middle, high: Integer;
begin
  low := 2; high := n;
  //low - 1: ko cat, high + 1: cat
  repeat
    middle := (low + high) div 2;
    if Check(middle) then
      high := middle - 1
    else
      low := middle + 1;
  until low > high;
  if low <= n then res := low
  else res := -1;
end;

procedure AllTasks;
begin
  Enter;
  Refine;
  InitTree;
  Solve;
end;

procedure DoCheck(obj: TJudger);
var
  f: TextFile;
  hsres: Integer;
begin
  //Solve
  AllTasks;
  obj.ev := 0;
  if not FileExists(OutputFile) then
    begin
      TTextEngine.MsgError('Output file not found', []);
      Exit;
    end;
  AssignFile(f, OutputFile); Reset(f);
  try
    try
      //Checking, set mark by ev from 0 to 1
      WriteLn('Checking the result: ');
      ReadLn(f, hsres);
      TTextEngine.bl1; WriteLn('Answer: ', res);
      TTextEngine.bl1; WriteLn('Output: ', hsres);
      if res <> hsres then
        GenErr('Ke^''t qua? sai', []);
      WriteLn;
      TTextEngine.MsgOK;
      obj.ev := 1;
    finally
      CloseFile(f);
    end;
  except
    on E:Exception do
      TTextEngine.MsgError(E.Message)
  end;
end;

begin
  Judger.Title := ProblemTitle;
  Judger.ExecCmd := ExeName;
  Judger.InputFormat := InputFormat;
  Judger.InputFile := InputFile;
  Judger.OutputFile := OutputFile;
  Judger.GetTestCases(TestCases);
  Judger.TimeLimit := TimeLimit;
  Judger.CheckProc := @DoCheck;
  Judger.Silent := TFileEngine.ParamStr(1) = '/SILENT';
  if Judger.Silent then
    Judger.LogFile := Prefix + '.log';
  Judger.Run;
  if Judger.Silent then
    TStdIO.Pause;
  if (Judger.Score + 1E-6 >= Judger.MaxScore) then
    TTextEngine.SayPerfect;
  Judger.ShowLog;
end.


