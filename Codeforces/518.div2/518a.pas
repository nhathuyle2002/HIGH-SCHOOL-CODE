Const   ginp='ss.inp';
        gout='ss.out';

Var     n,m,k,l,res:int64;

Procedure Process;
Begin
        readln(n,m,k,l);
        res:=(l-1+k) div m+1;
        if (l+k>n) or (res*m>n) then write(-1) else write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
