const   ginp='pairnum.inp';
        gout='pairnum.out';

var     n:longint;
        res:int64;
        d:array[0..100010] of longint;

procedure process;
var     i,x:longint;
begin
        readln(n);
        res:=0;
        for i:=1 to n do
        begin
                read(x);
                res:=res+d[x];
                inc(d[x]);
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
