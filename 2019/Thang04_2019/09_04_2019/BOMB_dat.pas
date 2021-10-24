
const   fi='BOMB.INP';
        fo='BOMB.OUT';
        maxn=32;
type    bignum=ansistring;
var     n,m,codinh,dem,dem2:longint;
        kq,c:bignum;
        dx:array[1..4] of longint=(1,-1,0,0);
        dy:array[1..4] of longint=(0,0,1,-1);
        cs,a:array[0..maxn,0..maxn] of longint;
        f:array[0..maxn*maxn,0..maxn*maxn] of longint;
procedure       nhap;
var     f:text;
        i,j:longint;
begin
        assign(f,fi); reset(f);
        readln(f,n,m);
        for i:=1 to n do
        begin
                for j:=1 to m do
                        read(f,a[i,j]);
                readln(f);
        end;
        close(f);
end;
procedure        cong(a,b:bignum);
var     s,i,nho:longint;
begin
        c:='';
        while length(a)<length(b) do a:='0'+a;
        while length(a)>length(b) do b:='0'+b;
        nho:=0;
        for i:=length(a) downto 1 do
        begin
                s:=ord(a[i])+ord(b[i])-96+nho;
                nho:=s div 10;
                c:=chr(s mod 10 +48)+c;
        end;
        if nho>0 then c:='1'+c;
end;
procedure       tinh(x:longint);
var     i:longint;
begin
        c:='1';
        for i:=1 to x do
                cong(c,c);
end;
procedure       capnhat(i,j:longint);
var     u,v,k:longint;
begin
        for u:=i+1 to dem2 do
        if f[u,j]=1 then
        begin
                for v:=1 to dem+1 do
                        f[u,v]:=(f[u,v]+f[i,v]) mod 2;
        end;
end;
procedure       xuli;
var     i,j,u,v,k,tmp:longint;
        kt:boolean;
begin
        dem:=0;
        dem2:=0;
        for i:=1 to n do
        for j:=1 to m do
        begin
                inc(dem);
                cs[i,j]:=dem;
        end;
        for i:=1 to n do
        for j:=1 to m do
        if a[i,j]>=0 then
        begin
                inc(dem2);
                tmp:=dem2;
                f[tmp,dem+1]:=a[i,j];
                for k:=1 to 4 do
                begin
                        u:=i+dx[k];
                        v:=j+dy[k];
                        if cs[u,v]>0 then
                                f[tmp,cs[u,v]]:=1;
                end;
                tmp:=cs[i,j];
        end;
        codinh:=0;
        for i:=1 to dem2 do
        begin
                kt:=false;
                for j:=1 to dem do
                if f[i,j]=1 then
                begin
                        kt:=true;
                        capnhat(i,j);
                        break;
                end;
                if kt=false then
                begin
                        if f[i,dem+1]=1 then
                        begin
                                kq:='0';
                                exit;
                        end;
                end
                else    inc(codinh);
        end;
        tinh(dem-codinh);
        kq:=c;
end;
procedure       xuat;
var     g:text;
begin
        assign(g,fo); rewrite(G);
        write(g,kq);
        close(g);
end;
begin
        nhap;
        xuli;
        xuat;
end.
