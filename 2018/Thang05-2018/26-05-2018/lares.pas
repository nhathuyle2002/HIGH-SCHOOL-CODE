const   ginp='lares.inp';
        gout='lares.out';
        max=round(1e9)+1;

var     gi,go:text;
        x,y,k,sn:int64;
        l,r,m:int64;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,x,y,k);
        sn:=x+y-k;
        l:=0;r:=max;
        while l<>r do
        begin
                m:=(l+r) div 2;
                if (2*m<=x) and (m<=y) and (3*m<=sn) then l:=m+1
                else r:=m;
        end;
        write(go,l-1);
        close(gi);close(go);
end.



