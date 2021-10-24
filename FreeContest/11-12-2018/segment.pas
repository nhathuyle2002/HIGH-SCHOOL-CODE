Const   ginp='segment.inp';
        gout='segment.out';
        maxn=200010;

Var     n,a,b:longint;
        x,y:array[0..maxn] of longint;


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
