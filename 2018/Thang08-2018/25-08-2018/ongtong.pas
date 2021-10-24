const   ginp='ongtong.inp';
        gout='ongtong.out';
        maxn=1000;
        base=trunc(1e9);

type    bignum=array[0..maxn] of longint;

var     n:longint;
        a,b,c,s:bignum;

operator + (x,y:bignum) z:bignum;
var     i,nho,sum:longint;
begin
        if x[0]>y[0] then z[0]:=x[0] else z[0]:=y[0];
        nho:=0;
        for i:=1 to z[0] do
        begin
                if i>x[0] then x[i]:=0;
                if i>y[0] then y[i]:=0;
                sum:=x[i]+y[i]+nho;
                z[i]:=sum mod base;
                nho:=sum div base;
        end;
        if nho>0 then
        begin
                inc(z[0]);
                z[z[0]]:=nho;
        end;
end;

procedure process;
var     i:longint;
        t:string;
begin
        read(n);
        a[0]:=0;
        b[0]:=1;b[1]:=1;
        s[0]:=0;
        for i:=1 to n-1 do
        begin
                c:=b;
                b:=b+a;
                a:=c;
                s:=s+b;
        end;
        write(s[s[0]]);
        for i:=s[0]-1 downto 1 do
        begin
                str(s[i],t);
                while length(t)<9 do t:='0'+t;
                write(t);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
