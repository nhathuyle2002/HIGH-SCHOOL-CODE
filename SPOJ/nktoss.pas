const   ginp='ss.inp';
        gout='ss.out';
        base=round(1e18);

type    bignum=array[0..1010] of int64;

var     k,n:longint;
        res:bignum;
        f,d:array[0..10010] of bignum;

operator + (a,b:bignum) c:bignum;
var     i,nho:longint;
begin
        if a[0]<b[0] then c[0]:=b[0] else c[0]:=a[0];
        nho:=0;
        for i:=1 to c[0] do
        begin
                if i>a[0] then a[i]:=0;
                if i>b[0] then b[i]:=0;
                c[i]:=a[i]+b[i]+nho;
                if c[i]>=base then
                begin
                        c[i]:=c[i]-base;
                        nho:=1;
                end else nho:=0;
        end;
        if nho>0 then
        begin
                inc(c[0]);
                c[c[0]]:=nho;
        end;
end;

operator - (a,b:bignum) c:bignum;
var     i,nho:longint;
begin
        if a[0]<b[0] then c[0]:=b[0] else c[0]:=a[0];
        nho:=0;
        for i:=1 to c[0] do
        begin
                if i>a[0] then a[i]:=0;
                if i>b[0] then b[i]:=0;
                c[i]:=a[i]-b[i]-nho;
                if c[i]<0 then
                begin
                        c[i]:=c[i]+base;
                        nho:=1;
                end else nho:=0;
        end;
        while (c[0]>1) and (c[c[0]]=0) do dec(c[0]);
end;

procedure process;
var     i:longint;
        ss:string[19];
begin
        readln(n,k);
        if n<k then
        begin
                write(0);
                exit;
        end;
        d[0,0]:=1;d[0,1]:=1;
        for i:=1 to n-k do
                d[i]:=d[i-1]+d[i-1];
        f[k,0]:=1;f[k,1]:=1;
        for i:=k+1 to n do
                f[i]:=f[i-1]+f[i-1]+d[i-k-1]-f[i-k-1];
        write(f[n,f[n,0]]);
        for i:=f[n,0]-1 downto 1 do
        begin
                str(f[n,i],ss);
                while length(ss)<18 do ss:='0'+ss;
                write(ss);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
