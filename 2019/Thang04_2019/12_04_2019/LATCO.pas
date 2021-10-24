const fi='LATCO.inp';
      fo='LATCO.out';
type data=array[0..300]of longint;
var   i,j,n,k,dem,kq,m,u:longint;
      tmp:char;
      a,b,t:data;
procedure nhap;
var   f:text;
begin
      assign(f,fi); reset(f);
      readln(f,n,m);
      for i:=0 to n-1 do
            begin read(f,tmp);
                  a[i]:=ord(tmp)-48;
            end;
      readln(f);
      for i:=0 to n-1 do
            begin read(f,tmp);
                  b[i]:=ord(tmp)-48;
            end;
      close(f);
end;
procedure xuli(a,b:data);
begin
      for i:=k to n+k-m do
            if a[i]<>b[i-k+u] then
            begin
                  for j:=i to i+m-1 do a[j]:=(a[j]+1) mod 2;
                  inc(dem);
            end;
      for i:=n+k-m to n+k-1 do
            if a[i]<>b[i-k+u] then
                  begin dem:=n;
                        exit;
                  end;
end;
procedure solve;
begin
      t:=b;
      for u:=1 to n do
            begin
                  t[n+u-1]:=t[u-1];
                  t[u-1]:=0;
                  dem:=0;
                  xuli(a,t);
                  if dem<kq then kq:=dem;
            end;
end;
procedure run;
begin
      kq:=n;
      for k:=1 to n do
            begin
                  a[n+k-1]:=a[k-1];
                  a[k-1]:=0;
                  solve;
            end;
end;
procedure xuat;
var   f:text;
begin
      assign(f,fo); rewrite(f);
      write(f,kq);
      close(F);
end;
begin
      nhap;
      run;
      xuat;
end.