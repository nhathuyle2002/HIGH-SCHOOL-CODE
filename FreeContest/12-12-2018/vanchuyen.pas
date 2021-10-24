Const   ginp='vanchuyen.inp';
        gout='vanchuyen.out';

Var     h,c,r,k:longint;

Procedure Process;
Begin
        read(h,c,r,k);
        if (h<=k) and (c<=k) and (r<=k) then write('YES') else
        write('NO');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
