const   ginp='bom.inp';
        gout='bom.out';

var     gi,go:text;
        n,s:Longint;
        a:array[0..50001] of int64;
        f,dem:array[0..1000,-1000..50000] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,s);
        for i:=1 to n do read(gi,a[i]);
end;

function max(x,y:Longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to n do
                for j:=1 to s do
                begin
                        if (j-a[i]>=0) then f[i,j]:=max(f[i-1,j],f[i-1,j-a[i]]+a[i])
                        else f[i,j]:=f[i-1,j];
                        if (j-a[i]>=0) and (f[i,j]<>f[i,j-1]) and (f[i,j]=f[i-1,j-a[i]]+a[i]) then
                                begin
                                        if a[i]=j then dem[i,j]:=dem[i-1,j]+1
                                        else dem[i,j]:=dem[i-1,j]+dem[i-1,j-a[i]];
                                end
                        else dem[i,j]:=dem[i-1,j];
                end;
end;

procedure output;
begin
        writeln(go,f[n,s]);
        write(go,dem[n,f[n,s]]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
