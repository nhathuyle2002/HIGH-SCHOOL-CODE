Uses    Math;

Const   ginp='table.inp';
        gout='table.out';
        maxn=301;
        oo=trunc(1e9);

Var     m,n,k,p,q,u,v:longint;
        res:int64;
        a,f,b:array[0..maxn,0..maxn] of int64;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
        b:=a;
End;

Procedure Process;
Var     i,j,x,y:longint;
Begin
        for k:=1 to k do
        begin
                readln(p,q,u,v);
                res:=oo;
                for x:=p to u do
                for y:=q to v do
                begin
                        if ((x=p) and (y=q)) or ((x=u) and (y=v)) then b[x,y]:=0 else b[x,y]:=-oo;
                        for i:=p to u do
                        for j:=q to v do
                        begin
                                f[i,j]:=-oo;
                                if (i=p) and (j=q) then f[i,j]:=b[i,j];
                                if (i>p) then f[i,j]:=max(f[i,j],f[i-1,j]+b[i,j]);
                                if (j>q) then f[i,j]:=max(f[i,j],f[i,j-1]+b[i,j]);
                        end;
                        b[x,y]:=a[x,y];
                        res:=min(res,f[u,v]);
                end;
                writeln(res);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
