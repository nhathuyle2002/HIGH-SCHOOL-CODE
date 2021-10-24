const   ginp='ss.inp';
        gout='ss.out';
        maxn=15003;
        kk=1000000000;

type    bignum=array[0..maxn+1] of longint;

var     gi,go:text;
        n,p:int64;
        ans:bignum;

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

function tinh(a,b:bignum):bignum;
var     i:longint;

function nhan(x:bignum;y:int64,vt:longint):bignum;
var     i,j:longint;
        tm,csn:int64;
begin
        i:=vt;
        fillchar(nhan,sizeof(nhan),0);
        repeat
                csn:=1;tm:=0;
                for j:=i downto i-9+1 do
                begin
                        tm:=tm+x[i]*csn;
                        csn:=csn*10;
                end;
                sum:=tm*y+nho;
                nho:=sum div kk;
                for j:=i downto i-9+1 do
                begin
                        nhan[i]:=sum mod 10;
                        sum:=sum div 10;
                end;
                i:=i-9;
        until i=0;
end;

begin
        fillchar(tinh,sizeof(tinh),0);
        i:=maxn;
        repeat
                csn:=1;tm:=0;
                for j:=i downto i-9+1 do
                begin
                        tm:=tm+b[i]*csn;
                        csn:=csn*10;
                end;
                tinh:=cong(tinh,nhan(a,tm),i);
                i:=i-9;
        until i=0;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);

        close(gi);close(go);
end.
