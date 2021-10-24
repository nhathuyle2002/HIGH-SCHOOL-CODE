const   ginp='ss.inp';
        gout='ss.out';
        kk=round(1e9)+7;

var     gi,go:text;
        n,m,res:longint;

procedure create;
var     i:longint;
begin
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        create;
        main;
        write(go,res);
        close(gi);close(go);
end.
