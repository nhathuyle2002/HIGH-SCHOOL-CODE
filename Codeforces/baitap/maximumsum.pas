Const   ginp='ss.inp';
        gout='ss.out';

Var     n,m:int64;
        res:longint;

Procedure Ccl;
Begin
        while n>0 do
        begin
                res:=res+n mod 10;
                n:=n div 10;
        end;
End;

Procedure Enter;
Begin
        read(n);
End;

Procedure Process;
Begin
        m:=0;
        while m*10+9<=n do m:=m*10+9;
        res:=0;
        n:=n-m; ccl;
        n:=m; ccl;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
