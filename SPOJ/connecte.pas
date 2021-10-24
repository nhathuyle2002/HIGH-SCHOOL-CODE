const   ginp='ss.inp';
        gout='ss.out';

var     n:longint;

procedure input;
var     i:longint;
begin
end;

procedure process;
var     i:longint;
begin
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewritr(output);
        input;
        process;
        close(input);close(output);
end.
