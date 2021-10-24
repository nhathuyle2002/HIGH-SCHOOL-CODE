const   ginp='triangle.inp';
        gout='triangle.out';

var     gi,go:text;
        n:longint;
        f,a:array[0..1001,0..1001] of longint;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure input;
var     i,j,m:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        m:=0;
        for i:=1 to n do
        begin
                inc(m);
                for j:=1 to m do
                begin
                        read(gi,a[i,j]);
                        f[i,j]:=max(f[i-1,j-1],f[i-1,j])+a[i,j];
                end;
        end;
end;

procedure output;
var     i,j,m,i0,j0:longint;
        trace:array[0..1001] of longint;
begin
        i0:=n;j0:=0;
        for i:=1 to n do
                if f[n,i]>f[n,j0] then j0:=i;
        writeln(go,f[i0,j0]);
        trace[1]:=a[i0,j0];
        while i0>0 do
                if j0=1 then
                begin
                        dec(i0);
                        trace[n-i0+1]:=a[i0,j0];
                end
                else if j0=i0 then
                begin
                        dec(i0);dec(j0);
                        trace[n-i0+1]:=a[i0,j0];
                end
                else if f[i0,j0]=f[i0-1,j0] then
                begin
                        dec(i0);
                        trace[n-i0+1]:=a[i0,j0];
                end
                else
                begin
                        dec(i0);dec(j0);
                        trace[n-i0+1]:=a[i0,j0];
                end;
        for i:=n downto 1 do write(go,trace[i],' ');
        close(gi);close(go);
end;

begin
        input;
        output;
end.















