Uses    Math;

Const   ginp='pole.inp';
        gout='pole.out';
        maxn=10000;
        maxh=1000;
        oo=trunc(1e13);

Var     n,d:longint;
        res:int64;
        h:array[0..maxn+1] of longint;
        f:array[0..maxn+1,0..maxh+1] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,d);
        for i:=1 to n do read(h[i]);
End;

Procedure Process;
Var     i,j:longint;
        m1,m2:array[0..maxh+1] of int64;
Begin
        for j:=1 to maxh do
                if j<h[1] then f[1,j]:=oo else f[1,j]:=sqr(j-h[1]);
        for i:=2 to n do
        begin
                m1[0]:=oo;
                for j:=1 to maxh do m1[j]:=min(m1[j-1],f[i-1,j]-j*d);
                m2[maxh+1]:=oo;
                for j:=maxh downto 1 do m2[j]:=min(m2[j+1],f[i-1,j]+j*d);
                for j:=1 to maxh do
                        if j<h[i] then f[i,j]:=oo else f[i,j]:=sqr(j-h[i])+min(m1[j]+j*d,m2[j]-j*d);
        end;
        res:=oo;
        for j:=1 to maxh do res:=min(res,f[n,j]);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
