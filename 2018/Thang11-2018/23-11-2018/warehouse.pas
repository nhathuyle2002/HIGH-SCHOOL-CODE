Uses    Math;

Const   ginp='warehouse.inp';
        gout='warehouse.out';
        maxn=1001;
        maxt=101;

Var     n,mt,d,res:longint;
        a,t:array[0..maxn] of longint;
        f:array[0..maxn,0..maxt] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,mt,d);
        for i:=1 to n do read(a[i]); readln;
        for i:=1 to n do read(t[i]);
End;

Procedure Process;
Var     i,j,k:longint;
Begin
        res:=0;
        for i:=1 to n do
                for j:=t[i] to mt do
                begin
                        for k:=i-1 downto max(i-d,0) do
                                f[i,j]:=max(f[i,j],f[k,j-t[i]]+a[i]);
                        res:=max(res,f[i,j]);
                end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
