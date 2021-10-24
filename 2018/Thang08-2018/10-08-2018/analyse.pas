const   ginp='analyse.inp';
        gout='analyse.out';
        base=trunc(1e9)+7;
        maxn=10000000;

var     n,st:longint;
        f,g:array[0..maxn] of int64;

function pow(k:longint):int64;
begin
        if k<=maxn then
                if g[k]>0 then exit(g[k]);
        pow:=pow(k shr 1);
        pow:=(pow*pow) mod base;
        if k and 1=1 then pow:=(pow*2) mod base;
        if k<=maxn then g[k]:=pow;
end;

function try(k:longint):int64;
var     i:longint;
begin
        if k<=maxn then
                if f[k]>0 then exit(f[k]);
        try:=pow(k-1)-1;
        for i:=2 to trunc(sqrt(k)) do
                if (k mod i = 0) then
                        try:=(try-try(k div i)-try(i)+2*base) mod base;
        if i=sqrt(k) then try:=(try+try(i)) mod base;
        if k<=maxn then f[k]:=try;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(st);
        g[0]:=1;
        while st>0 do
        begin
                readln(n);
                writeln(try(n));
                dec(st);
        end;
        close(input);close(output);
end.
