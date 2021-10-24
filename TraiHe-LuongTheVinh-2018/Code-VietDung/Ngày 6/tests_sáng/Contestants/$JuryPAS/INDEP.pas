{$MODE OBJFPC}
{$INLINE ON}
program IndependentSet;
const
  InputFile  = 'INDEP.INP';
  OutputFile = 'INDEP.OUT';
  maxN = Round(1E6);
  neginf = -maxN - 1;
type
  TGraph = record
    f, fi, fo, fio: Integer;
  end;
var
  s: AnsiString;
  stack: array[1..maxN] of Integer;
  graph: array[1..maxN] of TGraph;
  unitg: TGraph;
  top: Integer;
  res: Integer;

procedure Enter;
var
  f: TextFile;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, s);
  finally
    CloseFile(f);
  end;
end;

procedure Init;
begin
  top := 0;
  with unitg do
    begin
      f := 0;
      fi := 1;
      fo := 1;
      fio := neginf;
    end;
end;

function Max(x, y: Integer): Integer; inline;
begin
  if x > y then Result := x else Result := y;
end;

function OS(const x, y: TGraph): TGraph;
begin
  with Result do
    begin
      f := Max(x.f + y.f, x.fo + y.fi - 1);
      fi := Max(x.fi + y.f, x.fio + y.fi - 1);
      fo := Max(x.f + y.fo, x.fo + y.fio - 1);
      fio := Max(x.fi + y.fo, x.fio + y.fio - 1);
    end;
end;

function OP(const x, y: TGraph): TGraph;
begin
  with Result do
    begin
      f := x.f + y.f;
      fi := x.fi + y.fi - 1;
      fo := x.fo + y.fo - 1;
      fio := x.fio + y.fio - 2;
      if fio < neginf then fio := neginf;
    end;
end;

procedure Push(i: Integer); inline;
begin
  Inc(top);
  stack[top] := i;
end;

function Pop: Integer; inline;
begin
  Result := stack[top];
  Dec(top);
end;

procedure Solve;
var
  i: Integer;
begin
  for i := Length(s) downto 1 do
    begin
      case s[i] of
        'g': graph[i] := unitg;
        'S': graph[i] := OS(graph[pop], graph[pop]);
        'P': graph[i] := OP(graph[pop], graph[pop]);
      end;
      Push(i);
    end;
  with graph[1] do
    begin
      res := f;
      if fi > res then res := fi;
      if fo > res then res := fo;
      if fio > res then res := fio;
    end;
end;

procedure PrintResult;
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
  Init;
  Solve;
  PrintResult;
end.
SPSgggPgg
