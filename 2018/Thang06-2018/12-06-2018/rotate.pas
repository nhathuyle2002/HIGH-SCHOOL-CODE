const   ginp='rotate.inp';
        gout='rotate.out';

var     gi,go:text;
        a,b,c,d,res:longint;
        gmin:real;

procedure check(aa,bb,cc,dd,k:longint);
var     tm:real;
begin
        tm:=aa/cc-bb/dd;
        if tm>gmin then
        begin
                gmin:=tm;
                res:=k;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,a,b,c,d);
        gmin:=-trunc(1e9);
        check(a,b,c,d,0);
        check(c,a,d,b,1);
        check(d,c,b,a,2);
        check(b,d,a,c,3);
        write(go,res);
        close(gi);close(go);
end.
