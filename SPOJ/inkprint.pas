const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m:longint;
        a:array[0..10001] of longint;
        d:array[0..20001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure process;
var     i:longint;
begin
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
