const   ginp='diningb.inp';
        gout='diningb.out';
        oo=trunc(1e7);

var     n,res:longint;
        a,b,c:array[0..30010] of longint;

procedure process;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                readln(a[i]);
                b[i]:=b[i-1];
                if a[i]=2 then inc(b[i]);
        end;
        for i:=n downto 1 do
        begin
                c[i]:=c[i+1];
                if a[i]=1 then inc(c[i]);
        end;
        res:=oo;
        for i:=1 to n+1 do
                if b[i-1]+c[i]<res then res:=b[i-1]+c[i];
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
