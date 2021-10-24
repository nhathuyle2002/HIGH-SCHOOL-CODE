const   ginp='ss.inp';
        gout='ss.out';
        maxn=4000010;

var     gi,go:text;
        n:longint;
        h:array[0..maxn] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,h[i]);
end;

procedure process;
var     i:longint;
begin

end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
