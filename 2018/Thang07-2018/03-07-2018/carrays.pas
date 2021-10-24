const   ginp='carrays.inp';
        gout='carrays.out';
        base=round(1e9)+7;

var     n,k,m:longint;
        p,f:array[0..1000010] of int64;

procedure main;
var     i:longint;
begin
        read(n,m,k);
        p[0]:=1;f[k]:=m;
        for i:=1 to n do p[i]:=(p[i-1]*m) mod base;
        for i:=k+1 to n do f[i]:=(f[i-1]*m+p[i-k]*(m-1)-f[i-k]*(m-1)) mod base;
        write((f[n]+base) mod base);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
