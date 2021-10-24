const fi='seqgame.inp';
      fo='seqgame.out';
var n,m,k:longint;
    s,kq:ansistring;
    a:array[0..1000] of int64;
procedure nhap;
var kh:text;
    i,j:longint;
    x:string;
begin
  assign(kh,fi);
  reset(kh);
  readln(kh,n,k);
  for i:=1 to  n do
      read(kh,a[i]);
  close(kh);
end;
function chia(t:ansistring;b:int64):ansistring;
var i:longint;
  s,hold:int64;
 c:ansistring;
begin
 hold:=0;s:=0; c:='';
 for i:=1 to length(t) do
 begin
 hold:=hold*10 + ord(t[i])-48;
 s:=hold div b;
 hold:=hold mod b;
 c:=c+chr(s+48);
 end;
 while (length(c)>1) and(c[1]='0') do
delete(c,1,1);
 chia:=c;
end; 
function sosanh(x,y:ansistring):longint;
begin
    if length(x)>length(y) then exit(1);
    if length(y)>length(X) then exit(2);
    if x>y then exit(1)
    else exit(2);
end;
function nhan(t:ansistring;b:int64):ansistring;
var i :integer;
 carry,s :int64;
 c,tmp :ansistring;
 begin
 c:='';
 carry:=0;
 for i:=length(t) downto 1 do
 begin
 s:=(ord(t[i])-48) * b + carry;
 carry:= s div 10;
 c:=chr(s mod 10 + 48)+c;
 end;
 if carry>0 then str(carry,tmp) else tmp:='';
 nhan:=tmp+c;
 end; 
procedure xuli;
var i,j,u,v,x,y:longint;
    min:ansistring;
begin
kq:='1';
for i:=1 to n do
    kq:=nhan(kq,a[i]);
    for i:=1 to k do
        begin
            min:=chia(chia(kq,a[1]),a[2]);
            min:=nhan(min,(a[1]+a[2])*(a[1]+a[2]));
            u:=1;v:=2;
            for x:=1 to n do
                for y:=x+1 to n do
                    begin
                        s:=chia(kq,a[x]*a[y]);
                        s:=nhan(s,(a[x]+A[y])*(a[x]+a[y]));
                        if sosanh(s,min)=2 then
                           begin
                              min:=s;
                              u:=x;
                              v:=y;
                           end;
                    end;
            a[u]:=a[u]+a[v];
            a[v]:=a[u];
            kq:=min;
        end;
end;
procedure xuat;
var g:text;
begin
  assign(G,fo);
  rewrite(g);
  write(g,kq);
  close(g);
end;
begin
nhap;
xuli;
xuat;
end.

