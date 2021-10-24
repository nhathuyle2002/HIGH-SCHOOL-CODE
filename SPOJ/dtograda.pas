const   ginp='ss.inp';
        gout='ss.out';
        maxn=1000000;

var     gi,go:text;
        n,k,ans1,ans2:longint;
        d:array[0..maxn] of longint;

procedure input;
var     i,x:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do
        begin
                read(gi,x);
                inc(d[x]);
        end;
end;

procedure output;
var     i:longint;
begin
        for i:=1 to maxn do
        begin
                ans1:=ans1+d[i] div k;
                ans2:=ans2+d[i] mod k;
        end;
        writeln(go,ans2);write(go,ans1);
        close(gi);close(go);
end;

begin
        input;
        output;
end.
