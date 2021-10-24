Const   ginp='sale.inp';
        gout='sale.out';

Var     n,k,p,res:int64;

Procedure Process;
Begin
        read(n,p,k);
        res:=n div (k+1)*p*k+n mod (k+1)*p;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
