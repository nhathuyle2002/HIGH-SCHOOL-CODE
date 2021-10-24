const   ginp='rect.inp';
        gout='rect.out';

var     gi,go:text;
        n,l,r,l0,r0:int64;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n);
        l:=0;r:=0;
        if n<>0 then
        begin
                l:=trunc(sqrt(n))+1;r:=l;
                while (l>0) and (r>0) do
                begin
                        l0:=l;r0:=r;
                        if (l-1)*r>=n then dec(l);
                        if l*(r-1)>=n then dec(r);
                        if (l=l0) and (r=r0) then break;
                end;
        end;
        write(go,l,' ',r);
        close(gi);close(go);
end.
