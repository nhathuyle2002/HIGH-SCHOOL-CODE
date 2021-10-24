const   ginp='ss.inp';
        gout='ss.out';

var     n,res:longint;

procedure process;
var     i,tm:longint;
begin
        read(n);
        tm:=5;
        while tm<=n do
        begin
                res:=res+n div tm;
                tm:=tm*5;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
