const   ginp='service.inp';
        gout='service.out';
        maxn=510;
        oo=trunc(1e14);

var     n,st:longint;
        f,g:array[0..maxn,0..maxn] of int64;

procedure enter;
var     i,j,k,m,w:longint;
begin
        readln(n,m,st);
        for i:=1 to n do
                for j:=1 to n do
                        if i=j then
                        begin
                                f[i,j]:=0; g[i,j]:=0;
                        end else
                        begin
                                f[i,j]:=oo; g[i,j]:=oo;
                        end;
        for k:=1 to m do
        begin
                readln(i,j,w);
                if f[i,j]>w then
                begin
                        f[i,j]:=w; g[i,j]:=w;
                        f[j,i]:=w; g[j,i]:=w;
                end;
        end;
        for k:=1 to n do
                for i:=1 to n do
                if i<>k then
                for j:=1 to n do
                if (j<>k) and (j<>i) then
                        if (f[i,j]>f[i,k]+f[k,j]) or ((f[i,j]=f[i,k]+f[k,j]) and (g[i,j]>g[i,k])) then
                        begin
                                f[i,j]:=f[i,k]+f[k,j];
                                g[i,j]:=g[i,k];
                        end;
end;

procedure process;
var     u,x,y,z,i,t:longint;
        res:int64;
begin
        for t:=1 to st do
        begin
                readln(x,y,z);
                res:=0;
                for i:=1 to n do
                begin
                        u:=x;
                        if (f[i,y]<f[i,u]) or ((f[i,y]=f[i,u]) and (g[i,y]<g[i,u])) then u:=y;
                        if (f[i,z]<f[i,u]) or ((f[i,z]=f[i,u]) and (g[i,z]<g[i,u])) then u:=z;
                        res:=res+g[i,u];
                end;
                writeln(res*100);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
