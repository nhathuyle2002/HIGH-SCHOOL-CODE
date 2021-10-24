{$MODE OBJFPC}
program MaxRect;
const
  InputFile  = 'RECT.INP';
  OutputFile = 'RECT.OUT';
  maxMN = Round(5E5);
var
  stack: array[1..maxMN] of Integer;
  top: Integer;
  h: array[1..maxMN] of Integer;
  left, right: array[1..maxMN] of Integer;
  m, n: Integer;
  resS: Int64;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, m, n);
    for i := 1 to n do Read(f, h[i]);
  finally
    CloseFile(F);
  end;
end;

function Get: Integer;
begin
  Result := stack[top];
end;

procedure Pop;
begin
  Dec(top);
end;

procedure Push(i: Integer);
begin
  Inc(top);
  stack[top] := i;
end;

procedure DoAnalyse;
var
  i: Integer;
begin
  top := 0;
  for i := 1 to n do
    begin
      while (top <> 0) and (h[Get] >= h[i]) do
        Pop;
      if top = 0 then left[i] := 0
      else left[i] := Get;
      Push(i);
    end;
  top := 0;
  for i := n downto 1 do
    begin
      while (top <> 0) and (h[Get] >= h[i]) do
        Pop;
      if top = 0 then right[i] := n + 1
      else right[i] := Get;
      Push(i);
    end;
end;

procedure Solve;
var
  i: Integer;
  temp: Int64;
begin
  DoAnalyse;
  resS := -1;
  for i := 1 to n do
    begin
      temp := Int64(right[i] - left[i] - 1) * h[i];
      if resS < temp then
        resS := temp;
    end;
  for i := 1 to n do h[i] := m - h[i];
  DoAnalyse;
  for i := 1 to n do
    begin
      temp := Int64(right[i] - left[i] - 1) * h[i];
      if resS < temp then
        resS := temp;
    end;
end;

procedure PrintResult;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, OutputFile); Rewrite(f);
  try
    Write(f, resS);
  finally
    CloseFile(f);
  end;
end;

begin
  Enter;
  Solve;
  PrintResult;
end.

5 9
1 3 4 4 5 4 4 3 1
