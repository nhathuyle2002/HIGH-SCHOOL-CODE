const   ginp='ss.inp';
        gout='ss.out';

type    bignum=array[1..160] of longint;

var     gi,go:text;
        n,k:longint;
        a:array[0..100] of longint;
        d:array[0..100] of boolean;
        f:array[0..100] of bignum;
        p,re:bignum;

procedure input;
var     i:longint;
        s:string;
begin
        readln(gi,n,k);
        readln(gi,s);
        for i:=1 to length(s) do
                p[160-length(s)+i]:=ord(s[i])-48;
        for i:=1 to k do read(gi,a[i]);
end;

function nhan(x:bignum;t:longint):bignum;
var     i,sum,nho:longint;
begin
        nho:=0;
        for i:=160 downto 1 do
        begin
                sum:=x[i]*t+nho;
                nhan[i]:=sum mod 10;
                nho:=sum div 10;
        end;
end;

function cong(x,y:bignum):bignum;
var     i,nho,sum:longint;
begin
        nho:=0;
        for i:=160 downto 1 do
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
        for i:=160 downto 1 do
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
        for ii:=i to 160 do
                if x[ii]>y[ii] then exit(true)
                else if x[ii]<y[ii] then exit(false);
        exit(false);
end;

procedure process;
var     i,j,tm:longint;
begin
        f[0,160]:=1;
        for i:=1 to k do
                f[i]:=nhan(f[i-1],n-k+i);
        fillchar(d,sizeof(d),true);
        for i:=1 to k do
        begin
                for j:=1 to n do
                        if d[j] then
                        begin
                                if sosanh(p,f[k-i]) then p:=tru(p,f[k-i]) else break;
                        end;
                d[j]:=false;write(go,j,' ');
        end;
        fillchar(d,sizeof(d),true);
        for i:=1 to k do
        begin
                tm:=0;
                for j:=1 to a[i]-1 do
                        if d[j] then inc(tm);
                re:=cong(re,nhan(f[k-i],tm));
                d[a[i]]:=false;
        end;
        re:=cong(re,f[0]);
        writeln(go);
        j:=1;
        while re[j]=0 do inc(j);
        for i:=j to 160 do write(go,re[i]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;

        process;
        close(gi);close(go);
end.
