Uses    Math;

Const   ginp='service.inp';
        gout='service.out';
        maxn=501;
        oo=trunc(1e13);

Var     n,m,q:longint;
        f,g:array[0..maxn,0..maxn] of int64;
        res:int64;

Procedure Enter;
Var     i,j,k,w:longint;
Begin
        readln(n,m,q);
        for i:=1 to n do
                for j:=1 to n do
                        if i=j then f[i,j]:=0 else f[i,j]:=oo;
        for k:=1 to m do
        begin
                readln(i,j,w);
                f[i,j]:=min(f[i,j],w);
        end;
        for i:=1 to n do
                for j:=1 to n do
                begin
                        f[i,j]:=min(f[i,j],f[j,i]);
                        g[i,j]:=f[i,j];
                end;
        for k:=1 to n do
                for i:=1 to n do
                if (i<>k) then
                for j:=1 to n do
                if (j<>k) and (j<>i) then
                        if (f[i,j]>f[i,k]+f[k,j]) or ((f[i,j]=f[i,k]+f[k,j]) and (g[i,j]>g[i,k])) then
                        begin
                                f[i,j]:=f[i,k]+f[k,j];
                                g[i,j]:=g[i,k];
                        end;
End;

Procedure Process;
Var     i,x,y,z:longint;
        g1,g2:int64;
Begin
        for q:=1 to q do
        begin
                readln(x,y,z);
                res:=0;
                for i:=1 to n do
                begin
                        g1:=min(f[i,x],min(f[i,y],f[i,z]));
                        g2:=oo;
                        if f[i,x]=g1 then g2:=min(g2,g[i,x]);
                        if f[i,y]=g1 then g2:=min(g2,g[i,y]);
                        if f[i,z]=g1 then g2:=min(g2,g[i,z]);
                        res:=res+g2;
                end;
                writeln(res*100);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
