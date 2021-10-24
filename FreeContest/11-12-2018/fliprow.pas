Const   ginp='fliprow.inp';
        gout='fliprow.out';

Var     m,n:longint;
        a:array[0..maxn*maxn] of long

Procedure Enter;
Var     i:longint;
Begin
End;

Procedure Process;
Var     i:longint;
Begin
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
