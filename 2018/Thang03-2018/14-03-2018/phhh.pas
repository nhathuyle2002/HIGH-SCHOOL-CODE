const   ginp='pho.inp';
        gout='pho.out';

var     gi,go:text;
        n,d,c,i,j,k:longint;
        f:array[0..1001,0..1001] of int64;

procedure process;
begin
        for i:=0 to n-1 do
                for j:=0 to n-1 do
                        if i<>j then f[i,j]:=maxlongint;

        for i:=1 to n-1 do
        begin
                readln(gi,j,k);
                f[j,k]:=1;
                f[k,j]:=1;
        end;

        for k:=0 to n-1 do
                for i:=0 to n-1 do
                        for j:=0 to n-1 do
                                if f[i,j]>f[i,k]+f[k,j] then f[i,j]:=f[i,k]+f[k,j];
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        readln(gi,d,c);
        process;
        write(go,f[d,c]);
        close(gi);close(go);
end.
