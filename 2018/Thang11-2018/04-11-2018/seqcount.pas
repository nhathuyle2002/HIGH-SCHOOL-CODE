{$MODE OBJFPC}

Const   ginp='seqcount.inp';
        gout='seqcount.out';
        base=1234567890;

Var     n:longint;
Function Diophante(a,b,c:int64; var x,k:int64):boolean;
Var     m,n,r,xm,xn,xr,q:int64;
Begin

End;


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
