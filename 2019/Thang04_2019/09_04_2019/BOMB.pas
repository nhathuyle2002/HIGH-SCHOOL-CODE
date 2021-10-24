const fi='BOMB.inp';
      fo='BOMB.out';
type  bignum=ansistring;
var   i,j,n,m,k,kq,t,x,y:longint;
      a:array[1..40,1..40]of longint;
      s:array[0..910,0..910]of longint;
      ai:array[1..4]of longint=(-1,0,0,1);
      aj:array[1..4]of longint=(0,1,-1,0);
      kt:array[1..910]of longint;
      found:boolean;
      f:text;
procedure nhap;
var   f:text;
begin
      assign(f,fi); reset(f);
      readln(f,m,n);
      for i:=1 to m do
      for j:=1 to n do read(f,a[i,j]);
      close(f);
end;
function c(i,j:longint):longint;
begin
      if (j<1) or (i<1) or (j>n) or (i>m) then exit(0);
      c:=(i-1)*n+j;
end;
procedure build;
begin
      for i:=1 to m do
      for j:=1 to n do
      if a[i,j]>=0 then
      begin
            inc(k);
            for t:=1 to 4 do s[k,c(i+ai[t],j+aj[t])]:=1;
            s[k,m*n+1]:=a[i,j];
      end else inc(kq);
end;
procedure xuli;
begin
      for i:=1 to k do
      begin
            found:=false;
            for j:=1 to m*n do
                  if (s[i,j]=1) and (kt[j]=0) then
                  begin
                        found:=true;
                        for x:=i+1 to k do
                        if s[x,j]=1 then
                              for y:=1 to m*n+1 do
                                    if kt[j]=0 then s[x,y]:=(s[x,y]+s[i,y]) mod 2;
                        kt[j]:=1;
                        break;
                  end;
            if not found then
                  if s[i,m*n+1]=0 then inc(kq)
                  else begin writeln(f,0);
                             close(f);
                             halt;
                       end;
      end;
end;
function add(a,b:bignum):bignum;
var   i,du,s:longint;
begin
      du:=0;   add:='';
      for i:=length(a) downto 1 do
            begin
                  s:=du+ord(a[i])+ord(b[i])-96;
                  du:=s div 10;
                  s:=s mod 10;
                  add:=chr(s+48)+add;
            end;
      if du=1 then add:='1'+add;
      while add[1]='0' do delete(add,1,1);
end;
function tinh(a:longint):bignum;
begin
      tinh:='1';
      for i:=1 to a do
            tinh:=add(tinh,tinh);
end;
procedure xuat;
begin
      write(f,tinh(kq));
      close(F);
end;
begin
      nhap;
      build;
      assign(f,fo); rewrite(f);
      xuli;
      xuat;
end.
