const   ginp='ss.inp;
        gout='ss.out';

var     gi,go:text;
        n:longint;

procedure main;
var     i,ans:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        while not eof(gi) do
        begin
                readln(gi,n);
                ans:=0;
                for i:=1 to trunc(sqrt(2*n)) do
                        if (2*n) mod i=0 then
                                if ((2*n) div i-i) mod 2=1 then inc(ans);
                writeln(go,ans);
        end;
        close(gi);close(go);
end;

begin
        main;
end.
