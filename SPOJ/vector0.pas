const   ginp='ss.inp';
        gout='ss.out';

type    vector=record x,y:longint;end;

var     gi,go:text;
        n:longint;
        a:array

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
