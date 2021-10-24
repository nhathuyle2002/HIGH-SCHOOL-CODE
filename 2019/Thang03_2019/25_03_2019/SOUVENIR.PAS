{$mode objfpc}
uses crt;
const
  fi= 'SOUVENIR.INP';
  fo= 'SOUVENIR.OUT';
  MaxN = 10000;
type
  Arr1 = Array[1..MaxN] of integer;
  Arr2 = Array[1..MaxN] of Boolean;
var
  infile, outfile: text;
  N, Amount, Dmin: integer;
  Next, D, T: Arr1;
  Pre: ^Arr1;
  c,m: Real;
Procedure Creat;
var
  i: integer;
  B: Arr2;
begin
    assign(infile, fi);
    reset(infile);
    readln(infile, N, Amount);
    readln(infile, c);
    fillchar(D, sizeof(D), 0); fillchar(B, sizeof(B), true); Dmin:=MaxN;
    for i:=1 to N do
    begin
        readln(infile, next[i]);
        if next[i]>0 then
        begin
            inc(D[next[i]]); B[next[i]]:= false;
        end;
    end;
    for i:=1 to N do
    begin
        if D[i] < Dmin then Dmin:= D[i]; if Dmin = 0 then break;
    end;
    close(infile);
end;
Procedure Marku(u: integer);
var
  count, p: integer;
  B: Arr2;
begin
    fillchar(B, sizeof(B), true);
    count:= 0; p:=0;
    while u>0 do
    begin
         if not B[u] then break; B[u]:= false; inc(count);
         if t[u] < count then
         begin
             t[u]:= count; Pre^[u]:=p;
         end;
         p:= u; u:= next[u];
    end;
end;
Procedure Init;
var
  i: integer;
begin
    fillchar(T, sizeof(T), 0); New(Pre);
    for i:=1 to N do
    begin
        if D[i]= Dmin then Marku(i); D[i]:= i;
    end;
end;
Procedure Swap(var x,y:integer);
var
  tmp: integer;
begin
    tmp:=x; x:=y; y:=tmp;
end;
Procedure Sort(l,r:integer);
var
  i,j,mid:integer;
begin
    if l>=r then exit;
    i:=l; j:=r; mid:=t[(i+j) div 2];
    repeat
      while t[i] > mid do inc(i); while t[j] < mid do dec(j);
      if i <= j then
      begin
          Swap(t[i], t[j]); Swap(D[i], D[j]); inc(i); dec(j);
      end;
    until i> j;
    Sort(l,j); Sort(i,r);
end;
Procedure Process;
var
  i, j, count: integer; v:real;
  B:Arr2;
begin
    m:=0; count:=0;
    fillchar(B, sizeof(B), true);
    for i:=1 to N do
    if B[D[i]] then
    begin
        if count = Amount then exit; inc(count); j:= D[i];
        T[count]:= j; v:= c; m:= m + v;
        while Pre^[j] > 0 do
        begin
            if count = Amount then exit;
            j:= Pre^[j]; inc(count); T[count]:= j; B[j]:=false;
            v:= v*9/10; m:= m + v;
        end;
    end;
end;
Procedure Result1;
var
  i:integer;
begin
    assign(outfile, fo); rewrite(outfile);
    writeln(outfile, m:0:0);
    for i:= Amount downto 1 do writeln(outfile, T[i]);
    close(outfile);
end;
BEGIN
    Creat;
    Init;
    Sort(1,n);
    Process;
    Sort(1,Amount);
    Result1;
END.



