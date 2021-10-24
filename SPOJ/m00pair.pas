const   ginp='ss.inp';
        gout='ss.out';
        maxn=500;

type    bignum=array[1..maxn] of longint;

var     f:array[0..1000] of bignum;

function nhan(x:bignum):bignum;
var     i,nho,sum:longint;
begin
        nho:=0;
        for i:=maxn downto 1 do
        begin
                sum:=x[i]*2+nho;
                nho:=sum div 10;
                nhan[i]:=sum mod 10;
        end;
end;

function cong(x:bignum):bignum;
var     i,nho,sum:longint;
begin
        nho:=1;
        for i:=maxn downto 1 do
        begin
                sum:=x[i]+nho;
                nho:=sum div 10;
                cong[i]:=sum mod 10;
        end;
end;

function tru(x:bignum):bignum;
var     i,nho,sum:longint;
begin
        nho:=1;
        for i:=maxn downto 1 do
        begin
                sum:=x[i]-nho;
                if sum<0 then
                begin
                        nho:=1;
                        sum:=sum+10;
                end else nho:=0;
                tru[i]:=sum mod 10;
        end;
end;

procedure create;
var     i:longint;
begin
        f[2,maxn]:=1;
        for i:=3 to 1000 do
        begin
                f[i]:=nhan(f[i-1]);
                if i mod 2=0 then f[i]:=cong(f[i]) else f[i]:=tru(f[i]);
        end;
end;

procedure main;
var     gi,go:text;
        n,k,i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        while not eof(gi) do
        begin
                readln(gi,n);
                if (n=0) then break else
                if (n=1) then write(go,0) else
                begin
                        k:=1;
                        while f[n,k]=0 do inc(k);
                        for i:=k to maxn do write(go,f[n,i]);
                end;
                writeln(go);
        end;
        close(gi);close(go);
end;

begin
        create;
        main;
end.


