const   ginp='rmq.inp';
        gout='rmq.out';

var     n,q:longint;
        a:array[0..100010] of longint;
        f:array[0..100010,0..17] of longint;

procedure enter;
var     i:longint;
begin
        readln(n,q);
        for i:=1 to n do read(a[i]);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure init;
var     i,k:longint;
begin
        for i:=1 to n do f[i,0]:=a[i];
        for i:=n downto 1 do
                for k:=1 to trunc(ln(n-i+1)/ln(2)) do
                        f[i,k]:=min(f[i,k-1],f[i+1<<(k-1),k-1]);
end;

procedure process;
var     i,l,r,k:longint;
begin
        for i:=1 to q do
        begin
                readln(l,r);
                k:=trunc(ln(r-l+1)/ln(2));
                writeln(min(f[l,k],f[r-1<<k+1,k]));
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;

        init;
        process;
        close(input);close(output);
end.
