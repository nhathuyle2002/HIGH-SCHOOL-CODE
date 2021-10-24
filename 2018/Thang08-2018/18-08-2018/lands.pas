const   ginp='lands.inp';
        gout='lands.out';
        oo=trunc(1e10);
        mn=1000;

var     n,x,y,z:longint;
        a:array[0..101] of longint;
        f:array[0..101,-1001..1001] of int64;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

function abs(x:longint):longint;
begin
        if x<0 then abs:=-x else abs:=x;
end;

procedure process;
var     i,b,kc,j,tm,xx,yy:longint;
begin
        readln(n,x,y,z);
        for i:=1 to n do
        begin
                readln(a[i],b);
                a[i]:=a[i]-b;
        end;
        for j:=-mn to mn do f[0,j]:=oo;
        f[0,0]:=0;
        for i:=1 to n do
        begin
                for j:=-mn to mn do
                begin
                        f[i,j]:=oo;
                        for xx:=0 to -a[i] do
                                if j-a[i]-xx<=mn then f[i,j]:=min(f[i,j],f[i-1,j-a[i]-xx]+xx*x+abs(j-a[i]-xx)*z);
                        for yy:=0 to a[i] do
                                if j-a[i]+yy>=-mn then f[i,j]:=min(f[i,j],f[i-1,j-a[i]+yy]+yy*y+abs(j-a[i]+yy)*z);
                end;
        end;
        write(f[n,0]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
