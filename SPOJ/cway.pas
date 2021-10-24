const   ginp='ss.inp';
        gout='ss.out';
        maxn=3000;

type    bignum=array[0..maxn+1] of longint;

var     gi,go:text;
        n,k,kk:longint;
        ans,tm:bignum;

procedure create;
var     i,nn:longint;
begin
        i:=maxn;nn:=n-2;
        while nn>0 do
        begin
                tm[i]:=nn mod 10;
                dec(i);
                nn:=nn div 10;
        end;
end;

function cong(x,y:bignum):bignum;
var     i,nho,sum:longint;
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
var     i,nho,sum:longint;
begin
        nho:=0;
        for i:=maxn downto 1 do
        begin
                sum:=x[i]*y+nho;
                nhan[i]:=sum mod 10;
                nho:=sum div 10;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n);
        create;ans[maxn]:=1;
        ans:=cong(ans,tm);
        for k:=n-3 downto 1 do
        begin
                tm:=nhan(tm,k);
                ans:=cong(ans,tm);
        end;
        kk:=1;
        while ans[kk]=0 do inc(kk);
        for k:=kk to maxn do write(go,ans[k]);
        close(gi);close(go);
end.
