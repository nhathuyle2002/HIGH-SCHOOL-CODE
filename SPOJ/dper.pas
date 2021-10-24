const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;

procedure main;
var     i,n:longint;
        ans:int64;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n);
        ans:=1;
        for i:=2 to n do ans:=(ans*i) mod 76213;
        write(go,ans);
        close(gi);close(go);
end;

begin
        main;
end.
