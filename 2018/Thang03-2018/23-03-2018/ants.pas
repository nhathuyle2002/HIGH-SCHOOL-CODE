const   ginp='ants.inp';
        gout='ants.out';

var     gi,go:text;
        n,i:longint;
        ans,k,x:int64;

function max(xx,yy:int64):int64;
begin
        if xx>yy then exit(xx) else exit(yy);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do
        begin
                read(gi,x);
                if x<=0 then ans:=max(ans,-x) else ans:=max(ans,k-x);
        end;
        write(go,ans);
        close(gi);close(go);
end.
