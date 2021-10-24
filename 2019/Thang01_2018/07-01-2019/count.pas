Const   ginp='count.inp';
        gout='count.out';
        base=123456789;

Var     n,res:int64;

Function Pow(a,b:int64):int64;
Var     c:int64;
Begin
        if b=0 then exit(1);
        c:=pow(a,b div 2);
        pow:=c*c mod base;
        if b mod 2=1 then pow:=pow*a mod base;
End;

Procedure Enter;
Begin
        read(n);
End;

Procedure Process;
Begin
        res:=pow(2,n-1);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
