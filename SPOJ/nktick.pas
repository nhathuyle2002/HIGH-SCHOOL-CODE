const   ginp='ss.inp';
        gout='ss.out';

var     n:longint;
        f,t,r:array[0..60010] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do read(t[i]);readln;
        for i:=1 to n-1 do read(r[i]);
        f[1]:=t[1];
        for i:=2 to n do
                f[i]:=min(f[i-1]+t[i],f[i-2]+r[i-1]);
        write(f[n]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
