const fi = 'kfactor.inp'; fo = 'kfactor.out';
  MaxK = 100001; MaxD = 5000001;

var prime: array[1..MaxK] of boolean;
  v: array[0..MaxD] of longint;
  k, a, b : longint;
  i, j, d, rest : longint;
  res : longint;
  cou : longint;

BEGIN
  assign(input, fi); reset(input);
  readln(k, a, b);
  close(input);

  fillchar(prime, sizeof(prime),true);
  for i := 2 to trunc(sqrt(k)) do
    if  prime[i] then begin
    j := i*i;
    while j <= k do begin
      prime[j]:= false;
      j := j+i;
    end;
  end;

  for i := 0 to b - a do  v[i] := a + i;

  cou:=0;
  for d := 2 to k do
    if prime[d] then begin
      rest := a mod d;
      if rest > 0 then j := d - rest else j:=0;
      while j <= b - a do begin
        while V[j] mod  d = 0 do  v[j]:= v[j] div d;
        j := j + d;
        inc(cou);
      end;
    end;


  res := 0;
  for i := 0 to b - a do
    if v[i] = 1  then res := res + 1;

  assign(output, fo); rewrite(output);
  writeln(res);
  write(cou);
  close(output);
END.

