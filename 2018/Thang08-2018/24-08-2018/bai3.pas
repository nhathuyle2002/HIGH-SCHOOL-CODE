const   ginp='bai3.inp';
        gout='bai3.out';
        base=1000003;

var     n:longint;
        b:ansistring;
        a:array[0..1010] of ansistring;
        f:array[0..1010,0..1010] of longint;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do readln(a[i]);
        read(b);
end;

procedure process;
var     i,j:longint;
begin
        if a[1,1]=b[1] then f[1,1]:=1 else f[1,1]:=0;
        for i:=1 to n do
                for j:=1 to n do
                        if (i*j>1) and (a[i,j]=b[i+j-1]) then
                        begin
                                if i-1>0 then f[i,j]:=f[i-1,j] else f[i,j]:=0;
                                if j-1>0 then f[i,j]:=(f[i,j]+f[i,j-1]) mod base;
                        end;
        write(f[n,n]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
