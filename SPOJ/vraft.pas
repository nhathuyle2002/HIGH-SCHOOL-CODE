const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,k,ans:longint;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n,k);
end;

procedure try(sl:longint);
begin
        if (sl>k) and ((sl-k) mod 2=0) then
        begin
                inc(ans);
                try((sl-k) div 2);
                try((sl+k) div 2);
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        ans:=1;
        try(n);
        output;
end.