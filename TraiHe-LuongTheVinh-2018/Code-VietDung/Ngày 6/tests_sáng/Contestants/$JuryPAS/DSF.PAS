{$MODE OBJFPC}
const
  InputFile  = 'DSF.INP';
  OutputFile = 'DSF.OUT';
  maxN = Round(1E5);
  maxM = Round(2E5);
var
  lab: array[1..maxN] of Integer;
  i, n, m, u, v: Integer;
  fi, fo: TextFile;
  res: Integer;

function FindSet(u: Integer): Integer;
begin
  if lab[u] <= 0 then Result := u
  else
    begin
      Result := FindSet(lab[u]);
      lab[u] := Result;
    end;
end;

procedure Union(r, s: Integer);
begin
  if lab[r] < lab[s] then lab[s] := r
  else
    begin
      if lab[r] = lab[s] then Dec(lab[s]);
      lab[r] := s;
    end;
end;

begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
  try
    ReadLn(fi, n, m);
    FillChar(lab, SizeOf(lab), 0);
    res := n;
    for i := 1 to m do
      begin
        ReadLn(fi, u, v);
        u := FindSet(u); v := FindSet(v);
        if u <> v then
          begin
            Dec(res);
            Union(u, v);
          end;
        WriteLn(fo, res);
      end;
  finally
    CloseFile(fi); CloseFile(fo);
  end;
end.
