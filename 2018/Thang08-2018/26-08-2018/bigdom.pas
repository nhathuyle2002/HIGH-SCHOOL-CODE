const   ginp='bigdom.inp';
        gout='bigdom.out';

var     n,st:longint;
        a,p,q:array[0..100010] of int64;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do read(a[i]);
        readln;
end;

function max(x,y,z:int64):int64;
begin
        max:=x;
        if y>max then max:=y;
        if z>max then max:=z;
end;

function min(x,y,z:int64):int64;
begin
        min:=x;
        if y<min then min:=y;
        if z<min then min:=z;
end;

procedure process;
var     i:longint;
begin
        p[n+1]:=0;p[n+2]:=0;p[n+3]:=0;
        q[n+1]:=0;q[n+2]:=0;q[n+3]:=0;
        for i:=n downto 1 do
        begin
                p[i]:=max(q[i+1]+a[i],q[i+2]+a[i]+a[i+1],q[i+3]+a[i]+a[i+1]+a[i+2]);
                q[i]:=min(p[i+1],p[i+2],p[i+3]);
        end;
        writeln(p[1]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        readln(st);
        while st>0 do
        begin
                enter;
                process;
                dec(st);
        end;
        close(input);close(output);
end.
