const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        d:array[0..2500] of int64;
        res:int64;

procedure main;
var     i,j,gh:longint;
begin
        read(gi,n);
        gh:=n div 2+n mod 2;
        for i:=2 to n-2 do
                for j:=1 to i-1 do
                        if (j<gh) and (i-j<gh) then inc(d[i]);
        for i:=2 to n-2 do res:=res+d[i]*d[n-i];
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
