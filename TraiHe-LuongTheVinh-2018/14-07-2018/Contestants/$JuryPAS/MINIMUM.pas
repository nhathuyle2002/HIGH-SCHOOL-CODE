{$MODE OBJFPC}
program Task;
const
  InputFile  = 'MINIMUM.INP';
  OutputFile = 'MINIMUM.OUT';
  maxN = Round(5E5);
var
  fi, fo: TextFile;
  a: array[1..maxN] of Integer;
  q: array[1..maxN] of Integer;
  i, n, k, front, rear: Integer;


begin
  AssignFile(fi, InputFile); Reset(fi);
  AssignFile(fo, OutputFile); Rewrite(fo);
  try
    front := 1; rear := 0;
    ReadLn(fi, n, k);
    for i := 1 to n do
      begin
        Read(fi, a[i]);
        while (front <= rear) and (a[q[rear]] >= a[i]) do Dec(rear);
        Inc(rear);
        q[rear] := i;
        while (q[front] + k <= i) do Inc(front);
        if i >= k then
          WriteLn(fo, a[q[front]]);
      end;
  finally
    CloseFile(fi); CloseFile(fo);
  end;
end.

