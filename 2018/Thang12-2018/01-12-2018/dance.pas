Uses    Math;

Const   ginp='dance.inp';
        gout='dance.out';
        maxn=1002;
        oo=trunc(1e14);

Var     n,k:longint;
        h:array[0..maxn] of longint;
        f:array[0..maxn,0..maxn div 2] of int64;

Procedure Enter;
Var     i,j,tmp:longint;
Begin
        readln(n,k);
        for i:=1 to n do read(h[i]);
        for i:=1 to n do
                for j:=i+1 to n do
                        if h[i]>h[j] then
                        begin
                                tmp:=h[i]; h[i]:=h[j]; h[j]:=tmp;
                        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        f[0,0]:=0;
        for j:=1 to k do f[0,j]:=oo;
        for i:=1 to n do
                for j:=0 to k do
                begin
                        f[i,j]:=f[i-1,j];
                        if (j>0) and (i>1) then f[i,j]:=min(f[i,j],f[i-2,j-1]+h[i]-h[i-1]);
                end;
        write(f[n,k]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
