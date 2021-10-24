type    point

const   ginp='ss.inp';
        gout='ss.out';

var     n:longint;
        a:array[0..1501] of point;

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
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
