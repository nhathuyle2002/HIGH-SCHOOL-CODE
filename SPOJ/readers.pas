Uses    Math;

Const   ginp='readers.inp';
        gout='readers.out';
        maxn=100010;

Var     n,m:longint;
        t,c,d:array[0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to n do read(t[i]);
        readln;
        for i:=1 to m do read(c[i]);
End;

Procedure Process;
Var     i,j:longint;
Begin
        for i:=1 to m do
                for j:=1 to n do
                        d[j]:=max(d[j],d[j-1])+c[i]*t[j];
        write(d[n]);
End;

Begin
        assign(input,ginp); assign(output,gout);
        reset(input); rewrite(output);
        Enter;
        Process;
        close(input); close(output);
End.
