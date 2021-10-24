const fi='fib.inp';
      fo='fib.out';
var   a,b,n,aa:qword;
      i,m,t,test:longint;
      f,g:text;
      s:array[0..100000]of longint;
function gcd(a,b:qword):qword;
var   r:qword;
begin
      while b<>0 do
            begin
                  r:=a mod b;
                  a:=b; b:=r;
            end;
      gcd:=a;
end;
procedure nhap;
begin
      readln(f,a,b,m);
      aa:=a;
end;
procedure xuli;
begin
      s[1]:=1;  s[2]:=1;
      n:=0;
      for i:=3 to 100000 do
            begin
                  s[i]:=(s[i-1]+s[i-2]) mod m;
                  if (s[i]=1) and (s[i-1]=1) and (n=0) then n:=i-2;
            end;
      a:=a mod n;
end;
function lt(b:qword):longint;
var   t:longint;
begin
      if b=0 then exit(1);
      t:=lt(b div 2);
      t:=(t*t) mod n;
      if b mod 2=1 then t:=(t*a) mod n;
      lt:=t;
end;
procedure run;
begin
      assign(f,fi); reset(f);
      assign(g,fo); rewrite(g);
      readln(f,test);
      while test>0 do
            begin
                  nhap;
                  xuli;
                  t:=lt(b);
                  writeln(g,s[t],' ',s[gcd(aa,b) mod n]);
                  dec(test);
            end;
      close(f);  close(g);
end;
begin
      run;
end.