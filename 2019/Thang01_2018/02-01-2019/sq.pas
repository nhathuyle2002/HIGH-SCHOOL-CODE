Const   ginp='sq.inp';
        gout='sq.out';

Var     n:longint;


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
