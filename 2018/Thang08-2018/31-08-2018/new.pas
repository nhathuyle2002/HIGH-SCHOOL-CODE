const   ginp='.inp';
        gout='.out';

var     n:longint;

procedure enter;
var     i:longint;
begin
end;

procedure process;
var     i:longint;
begin
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
