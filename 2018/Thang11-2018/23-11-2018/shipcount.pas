Const   ginp='shipcount.inp';
        gout='shipcount.out';
        maxn = 501;
        base = trunc(1e9)+7;

Var     n,k:longint;
        f,a:array[0..maxn,0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(k,n);
End;

Procedure Init;
Var     i,j:longint;
Begin
        for j:=0 to n do
        begin
                a[0,j]:=1;
                for i:=1 to j do
                        a[i,j]:=(a[i-1,j]*(j-i+1)) mod base;
        end;
End;

Procedure Process;
Var     i,j,t:longint;
Begin
        f[0,0]:=1;
        for i:=1 to k do
                for j:=0 to n do
                        for t:=j downto 0 do
                                f[i,j]:=(f[i,j]+f[i-1,j-t]*a[t,j]) mod base;
        write(f[k,n]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        Process;
        Close(input); Close(output);
End.
