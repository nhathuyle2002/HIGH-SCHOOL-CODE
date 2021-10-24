const   ginp='lares.inp';
        gout='lares.out';
        max=trunc(1e9);

var     gi,go:text;
        m,n,k,l,r,mid:int64;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,m,n,k);
        l:=1;r:=max;
        while l<>r do
        begin
                mid:=(l+r) shr 1;
                if (2*mid<=m) and (mid<=n) and (m+n-3*mid>=k) then
                l:=mid+1 else r:=mid;
        end;
        write(go,l-1);
        close(gi);close(go);
end.