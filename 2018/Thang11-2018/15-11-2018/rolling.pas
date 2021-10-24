Const   ginp='rolling.inp';
        gout='rolling.out';
        d:array[0..3] of int64 =(0,6,10,11);

Var     n,k:int64;

Function Calc(m:int64):int64;
Begin
        calc:=m div 4 *14 + d[m mod 4];
End;

Procedure Enter;
Begin
        readln(n,k);
End;

Procedure Process;
Begin
        write(n div k *calc(k)+ calc(n mod k));
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
