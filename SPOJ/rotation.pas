const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;

procedure main;
var     i,n,res:longint;
        s,d,c:longint;
begin
        res:=0;
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,s,d,c);
                res:=res xor c;
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
