{$MODE OBJFPC}
{$INLINE ON}
program Employment;
uses Math;
const
  InputFile  = 'PROJECT.INP';
  OutputFile = 'PROJECT.OUT';
  maxN = Round(4E5);
var
  a, b: array[1..maxN + 1] of Integer;
  queue: array[1..maxN] of Integer;
  front, rear: Integer;
  n: Integer;
  H, S, D: Int64;
  T: Integer;
  TotalCost: Int64;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n);
    ReadLn(f, H, S, D);
    for i := 1 to n do Read(f, a[i]);
  finally
    CloseFile(f);
  end;
end;

function NotEmpty: Boolean; inline;
begin
  Result := front <= rear;
end;

procedure Push(v: Integer); inline;
begin
  Inc(rear); queue[rear] := v;
end;

procedure Solve;
var
  i, j, nRemove, e: Integer;
begin
  T := (H + D) div S;
  rear := 0; front := 1;
  for i := 2 to 1 + T do
    begin
      if i > n then Break;
      while NotEmpty and (a[queue[rear]] < a[i]) do Dec(rear);
      Push(i);
    end;
  b[1] := a[1];
  b[n] := a[n];
  for i := 2 to n - 1 do
    begin
      j := i + T;
      if j <= n then
        begin
          while NotEmpty and (a[queue[rear]] < a[j]) do Dec(rear);
          Push(j);
        end;
      while queue[front] < i do Inc(front);
      if a[i] >= b[i - 1] then b[i] := a[i]
      else
        begin
          e := a[queue[front]];
          if b[i - 1] > e then nRemove := b[i - 1] - e
          else nRemove := 0;
          b[i] := b[i - 1] - nRemove;
        end;
    end;
  b[n + 1] := 0;
  TotalCost := b[1] * (H + S);
  for i := 2 to n + 1 do
    begin
      if b[i] >= b[i - 1] then
        TotalCost := TotalCost + (b[i] - b[i - 1]) * H
      else
        TotalCost := TotalCost + (b[i - 1] - b[i]) * D;
      TotalCost := TotalCost + b[i] * S;
    end;
end;

procedure PrintResult;
var
  f:TextFile;
  i: Integer;
begin
  AssignFile(f, OutputFile); Rewrite(f);
  try
    WriteLn(f, TotalCost);
    for i := 1 to n do Write(f, b[i], ' ');
  finally
    CloseFile(f);
  end;
end;

begin
  Enter;
  Solve;
  PrintResult;
end.
3
4 5 6
10 9 11
