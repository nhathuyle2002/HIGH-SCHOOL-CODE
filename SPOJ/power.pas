const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        l,r:int64;
        res,st,co:longint;

procedure main;
var     i,j,tm:longint;
        t:real;
begin
        for i:=40 downto 1 do
        begin
                tm:=trunc(exp(ln(l)/i));
                for j:=tm to tm+1 do
                begin
                        t:=exp(ln(j)*i);
                        if (l<=t) and (t<=r) then
                        begin
                                res:=i;
                                exit;
                        end;
                end;
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        readln(gi,st);
        for co:=1 to st do
        begin
                readln(gi,l,r);
                main;
                writeln(go,'Case #',co,': ',res);
        end;
        close(gi);close(go);
end.
