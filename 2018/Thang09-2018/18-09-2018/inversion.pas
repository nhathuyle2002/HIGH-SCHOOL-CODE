Const   ginp='inversion.inp';
        gout='inversion.out';

Var     n:longint;
        a,res:array[0..1010] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
End;

Procedure Process;
Var     i,j:longint;
Begin
        for i:=1 to n do
                for j:=i-1 downto 1 do
                        if a[j]>a[i] then inc(res[a[i]]);
        for i:=1 to n do write(res[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
