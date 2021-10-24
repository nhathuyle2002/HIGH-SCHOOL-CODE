const   ginp='ss.inp';
        gout='ss.out';
        maxn=3500;

type    bignum=array[0..maxn+1] of byte;

var     gi,go:text;
        n,k:longint;
        f:array[0..1001] of bignum;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n,k);
end;

function cong(x,y:bignum):bignum;
var     nho,sum,i:longint;
begin
        nho:=0;
        for i:=maxn downto 1 do
        begin
                sum:=x[i]+y[i]+nho;
                nho:=sum div 10;
                cong[i]:=sum mod 10;
        end;
end;

function nhan(x:bignum;y:longint):bignum;
var     nho,sum,i:longint;
begin
        nho:=0;
        for i:=maxn downto 1 do
        begin
                sum:=x[i]*y+nho;
                nho:=sum div 10;
                nhan[i]:=sum mod 10;
        end;
end;

procedure D_P;
var     i:longint;
begin
        f[0,maxn]:=1;f[1]:=nhan(f[0],k-1);
        for i:=2 to n do
                f[i]:=nhan(cong(f[i-1],f[i-2]),k-1);
end;

procedure output;
var     i,kk:longint;
begin
        if n=1 then write(go,k)
        else
        begin
        kk:=1;
        while f[n,kk]=0 do inc(kk);
        for i:=kk to maxn do write(go,f[n,i]);
        end;
        close(gi);close(go);
end;

begin
        input;
        D_P;
        output;
end.
