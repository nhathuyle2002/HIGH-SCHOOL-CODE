const   ginp='';
        gout='';

var     gi,go:text;
        a,b,tm:int64;

function uc(x,y:int64):int64;
begin
        if x=0 then exit(y);
        uc:=uc(y mod x,x);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,a,b);
        write(go,uc(a,b));
        close(gi);close(go);
end.
