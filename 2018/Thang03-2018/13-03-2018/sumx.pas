const   ginp='sumx.inp';
        gout='sumx.out';

var     gi,go:text;
        dpp,a:array[0..200001] of longint;
        n,s,i:longint;
        dem:int64;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                inc(dpp[a[i]]);
        end;
        readln(gi);
        read(gi,s);
        dem:=0;
        if s mod 2=1 then
                for i:=1 to s div 2 do
                        dem:=dem+dpp[i]*dpp[s-i]
        else
        begin
                for i:=1 to s div 2-1 do
                        dem:=dem+dpp[i]*dpp[s-i];
                if dpp[s div 2]>1 then dem:=dem+(dpp[s div 2]*(dpp[s div 2]-1) div 2);
        end;
        write(go,dem);
        close(gi);close(go);
end.
