const   ginp='guessnumber.inp';
        gout='guessnumber.out';

var     gi,go:text;
        n:longint;
        a:array[0..100001] of longint;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n);
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