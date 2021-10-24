const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;

procedure input;
var
begin
end;

procedure process;
var
begin
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
