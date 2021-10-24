const   ginp='wood.inp';
        gout='wood.out';
        kk=1000000007;

var     gi,go:text;
        n,k:longint;
        a,f:array[0..1000001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,k,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure process;
var     i,j:longint;
begin
        f[0]:=1;
        for i:=1 to k do
                for j:=1 to n do
                        if i-a[j]>=0 then
                        f[i]:=(f[i]+f[i-a[j]]) mod kk;
end;

procedure output;
begin
        write(go,f[k]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
























