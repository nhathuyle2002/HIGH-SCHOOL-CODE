Const   ginp='mapping.inp';
        gout='mapping.out';

Var     x,y,res:int64;

Procedure Process;
Begin
        read(x,y);
        res:=(x+y-1)*(x+y-2) div 2+y;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
