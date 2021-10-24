const   fi='flower.INP';
        fo='flower.OUT';
        base=trunc(1e9)+7;
        maxn=100000;
var     n,m,k:longint;
        kq:int64;
        f1,f2,f3,f4:array[1..maxn] of int64;
procedure       nhap;
var     f:text;
begin
        assign(f,fi); reset(f);
        readln(f,n,m,k);
        close(f);
end;
procedure       xuli;
var     i,j,u,v,x:longint;
        tmp:int64;
begin
        for i:=1 to m do
        begin
                if i>=1 then
                        f1[i]:=1;
                if i>=2 then
                        f2[i]:=(f2[i-1]*2+2) mod base;
                if i>=3 then
                        f3[i]:=(f2[i-1]*3+f3[i-1]*3) mod base;
                if i>=4 then
                        f4[i]:=(f4[i-1]*4+f3[i-1]*4) mod base;
        end;
        kq:=0;
        if k<=1 then
                kq:=4;
        if k<=2 then
                kq:=(kq+f2[m]*(3+2+1)) mod base;
        if k<=3 then
                kq:=(kq+f3[m]*4) mod base;
        if k<=4 then
                kq:=(kq+f4[m]) mod base;
        tmp:=kq;
        for i:=1 to n-1 do
                kq:=(kq*tmp) mod base;
end;
procedure       xuat;
var     G:text;
begin
        assign(g,fo); rewrite(g);
        write(g,kq);
        close(g);
end;
begin
        nhap;
        xuli;
        xuat;
end.
