const   ginp='ss.inp';
        gout='ss.out';
        maxn=10001;

type    bignum=array[1..maxn] of byte;

var     gi,go:text;
        n:longint;
        a:array[0..101] of byte;
        s:array[0..9] of longint;
        res,sum,b,c:bignum;

procedure input;
var     i:longint;
        ss:string;
begin
        read(gi,ss);
        while ss[1]=' ' do delete(ss,1,1);
        n:=length(ss);
        for i:=1 to n do
                a[n-i+1]:=ord(ss[i])-48;
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

function cong4(x,y,z,t:bignum):bignum;
var     i,nho,sum:longint;
begin
        nho:=0;
        for i:=maxn downto 1 do
        begin
                sum:=x[i]+y[i]+z[i]+t[i]+nho;
                nho:=sum div 10;
                cong4[i]:=sum mod 10;
        end;
end;

function nhan(x:bignum;y:longint):bignum;
var     i,sum,nho:longint;
begin
        nho:=0;
        for i:=maxn downto 1 do
        begin
                sum:=x[i]*y+nho;
                nho:=sum div 10;
                nhan[i]:=sum mod 10;
        end;
end;

procedure process;
var     i,tm,j:longint;
begin
        for i:=1 to 9 do s[i]:=s[i-1]+i;
        for i:=1 to n do
        begin
                if (a[i]=0) and (i=n) then break;
                if a[i]=0 then
                begin
                        b[maxn]:=a[i+1];
                        res:=cong(res,b);
                        b[maxn]:=0;
                        dec(a[i+1]);a[i]:=10;
                end;
                b[maxn-i+1]:=1;
                if i=1 then c[maxn]:=1 else
                        for j:=1 to i-1 do c[maxn-j+1]:=a[j];
                res:=cong4(res,nhan(b,s[a[i]-1]),nhan(sum,a[i]-1),nhan(c,a[i] mod 10));
                sum:=cong(nhan(b,s[9]),nhan(sum,10));
                b[maxn-i+1]:=0;
        end;
        tm:=1;
        while res[tm]=0 do inc(tm);
        for i:=tm to maxn do write(go,res[i]);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
