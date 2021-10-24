Const   ginp='.inp';
        gout='.out';

Var     n:longint;

Procedure Enter;
Var     i:longint;
Begin
End;

Procedure Process;
Var     i:longint;
Begin
End;

Procedure Sinh;
Var     i,j:longint;
        Function R(x:longint):longint;
        Begin
                r:=random(x);
        End;
Begin
        Assign(output,ginp); Rewrite(output);
        Close(output);
End;

Begin
        //Sinh;
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
