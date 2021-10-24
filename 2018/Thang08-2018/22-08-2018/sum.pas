const   ginp='sum.inp';
        gout='sum.out';
        base=trunc(1e9)+7;

var     n:longint;
        f:array[0..4010,0..4010] of longint;

procedure process;
var     i,j:longint;
begin
        read(n);
        f[0,0]:=1;
        for i:=1 to n do
                for j:=0 to n do
                begin
                        f[i,j]:=f[i-1,j];
                        if j-i>=0 then f[i,j]:=(f[i-1,j-i]+f[i,j]) mod base;
                end;
        write(f[n,n]-1);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
