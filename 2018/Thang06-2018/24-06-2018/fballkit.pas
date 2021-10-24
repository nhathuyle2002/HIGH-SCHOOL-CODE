const   ginp='fballkit.inp';
        gout='fballkit.out';

var     gi,go:text;
        n:longint;
        x,y,d:array[0..100010] of longint;

procedure main;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,x[i],y[i]);
                inc(d[x[i]]);
        end;
        for i:=1 to n do writeln(go,n-1+d[y[i]],' ',n-1-d[y[i]]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.