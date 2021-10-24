Const   ginp='ss.inp';
        gout='ss.out';

Var     m,n,k,res:longint;

Procedure Process;
Var     i:longint;
Begin
        readln(m,n,k);
        res:=0;
        for i:=1 to k do
        begin
                res:=res+(n+m)*2-4;
                n:=n-4; m:=m-4;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
