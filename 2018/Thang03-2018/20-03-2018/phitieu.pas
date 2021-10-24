const   ginp='phitieu.inp';
        gout='phitieu.out';

var     gi,go:text;
        n,n2:longint;
        a,f,trace:array[-2..1000001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        i:=0;
        while not eof(gi) do
        begin
                while (eoln(gi)) and (not eof(gi)) do readln(gi);
                while (i<n) and (not eof(gi)) do
                begin
                        inc(i);
                        read(gi,a[i]);
                end;
        end;
end;

function max(x,y,z:int64):int64;
begin
        max:=x;
        if max<y then max:=y;
        if max<z then max:=z;
end;

procedure process;
var     i:longint;
begin
        for i:=1 to n do
                f[i]:=max(f[i-1],f[i-2]+a[i],f[i-3]+a[i]+a[i-1]);
        i:=n;
        n2:=0;
        while i>0 do
        begin
                if f[i]=f[i-3]+a[i]+a[i-1] then
                begin
                        inc(n2);trace[n2]:=i;
                        inc(n2);trace[n2]:=i-1;
                        dec(i,3);
                end
                else
                if f[i]=f[i-2]+a[i] then
                begin
                        inc(n2);trace[n2]:=i;
                        dec(i,2);
                end
                else dec(i);
        end;
end;

procedure output;
var     i:longint;
begin
        for i:=n2 downto 1 do
                if trace[i]>0 then break;
        n2:=i;
        writeln(go,n2,' ',f[n]);
        for i:=1 to n2 do writeln(go,trace[i]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.






