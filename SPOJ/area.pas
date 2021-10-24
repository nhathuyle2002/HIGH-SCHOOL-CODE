const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;

procedure input;
var     i:longint;
begin
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
