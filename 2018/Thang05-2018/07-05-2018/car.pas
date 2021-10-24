const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);

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
