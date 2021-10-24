const   ginp='ss.inp';
        gout='ss.out';
        mx=100;

type    bignum=array[1..mx] of longint;

var     gi,go:text;
        n,k:longint;
        a,b:array[0..300] of longint;
        f:array[0..300,0..300] of bignum;
        p,re:bignum;

procedure input;
var     i:longint;
        s:string;
begin
        readln(gi,n,k);
        readln(gi,s);
        for i:=1 to length(s) do
                p[mx-length(s)+i]:=ord(s[i])-48;
        for i:=1 to k do read(gi,a[i]);
end;

{function nhan(x:bignum;t:longint):bignum;
var     i,sum,nho:longint;
begin
        nho:=0;
        for i:=mx downto 1 do
        begin
                sum:=x[i]*t+nho;
                nhan[i]:=sum mod 10;
                nho:=sum div 10;
        end;
end;

function chia(x:bignum;t:longint):bignum;
var     i,sum,nho:longint;
begin
        nho:=0;
        for i:=1 to mx do
        begin
                sum:=10*nho+x[i];
                chia[i]:=sum div t;
                nho:=sum-(sum div t)*t;
        end;
end;}

function cong(x,y:bignum):bignum;
var     i,nho,sum:longint;
begin
        nho:=0;
        for i:=mx downto 1 do
        begin
                sum:=x[i]+y[i]+nho;
                cong[i]:=sum mod 10;
                nho:=sum div 10;
        end;
end;

function tru(x,y:bignum):bignum;
var     i,nho,sum:longint;
begin
        nho:=0;
        for i:=mx downto 1 do
        begin
                sum:=x[i]-y[i]-nho;
                if sum<0 then
                begin
                        sum:=sum+10;
                        nho:=1;
                end else nho:=0;
                tru[i]:=sum mod 10;
        end;
end;

function sosanh(x,y:bignum):boolean;
var     i,j,ii:longint;
begin
        i:=1;j:=1;
        while x[i]=0 do inc(i);
        while y[j]=0 do inc(j);
        if i<j then exit(true);
        if j<i then exit(false);
        for ii:=i to mx do
                if x[ii]>y[ii] then exit(true)
                else if x[ii]<y[ii] then exit(false);
        exit(false);
end;

procedure process;
var     i,j,tm:longint;
begin
        f[0,0,mx]:=1;
        for i:=1 to n do
        begin
                f[i,0,mx]:=1;f[i,i,mx]:=1;
                for j:=1 to i-1 do
                        f[i,j]:=cong(f[i-1,j],f[i-1,j-1]);
        end;
        b[0]:=0;
        for i:=1 to k do
        begin
                for j:=b[i-1]+1 to n do
                        if sosanh(p,f[n-j,k-i]) then p:=tru(p,f[n-j,k-i])
                        else break;
                b[i]:=j;
        end;
        a[0]:=0;
        for i:=1 to k do
                for j:=a[i-1]+1 to a[i]-1 do
                        re:=cong(re,f[n-j,k-i]);
        re:=cong(re,f[0,0]);
end;

procedure output;
var     i,j:longint;
begin
        for i:=1 to k do write(go,b[i],' ');
        writeln(go);
        j:=1;
        while re[j]=0 do inc(j);
        for i:=j to mx do write(go,re[i]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        output;
        close(gi);close(go);
end.
