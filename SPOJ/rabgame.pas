const   ginp='ss.inp';
        gout='ss.out';
        maxn=600;

type    bignum=array[0..maxn+1] of longint;

var     gi,go:text;
        n,k,kk:longint;
        f:array[0..501] of bignum;

function cong(x,y:bignum):bignum;
var     i,nho,sum:longint;
begin
        nho:=0;cong[0]:=0;
        for i:=maxn downto 1 do
        begin
                sum:=x[i]+y[i]+nho;
                nho:=sum div 10;
                cong[i]:=sum mod 10;
        end;
end;

function nhan(x:bignum;y:longint):bignum;
var     i:longint;
begin
        for i:=0 to maxn do nhan[i]:=0;
        for i:=1 to y do nhan:=cong(nhan,x);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        f[1,maxn]:=1;f[2,maxn]:=2;
        for k:=3 to n do
        begin
                f[k]:=nhan(f[k-2],k-1);
                f[k]:=cong(f[k],f[k-1]);
        end;
        kk:=1;
        while f[n,kk]=0 do inc(kk);
        for k:=kk to maxn do write(go,f[n,k]);
        close(gi);close(go);
end.
