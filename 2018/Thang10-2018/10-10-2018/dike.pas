Const   ginp='dike.inp';
        gout='dike.out';
        maxr=5*trunc(1e7);

Var     n:int64;

Procedure Process;
Var     i:longint;
        sum,ssum:int64;
Begin
        read(n);
        sum:=0; ssum:=0;
        for i:=1 to maxr do
        begin
                sum:=sum+i;
                ssum:=ssum+sum+i;
                if ssum-1>n then break;
        end;
        write(i-1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
