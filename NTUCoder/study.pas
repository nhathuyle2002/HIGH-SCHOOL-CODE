const   ginp='ss.inp';
        gout='ss.out';

var     m,n:longint;
        ou:array[0..101] of longint;
        a,f,v:array[0..101,0..101] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
end;

procedure process;
var     i,j,jj:longint;
begin
        for i:=1 to m do
                for j:=1 to n do
                        for jj:=0 to j do
                                if f[i,j]<f[i-1,jj]+a[i,j-jj] then
                                begin
                                        f[i,j]:=f[i-1,jj]+a[i,j-jj];
                                        v[i,j]:=jj;
                                end;
        writeln(f[m,n]);
        j:=n;
        for i:=m downto 1 do
        begin
                ou[i]:=j-v[i,j];
                j:=v[i,j];
        end;
        for i:=1 to m do writeln(ou[i]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
