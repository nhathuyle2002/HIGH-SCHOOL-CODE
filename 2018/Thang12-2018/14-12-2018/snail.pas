Const   ginp='snail.inp';
        gout='snail.out';

Var     t,n:int64;

Procedure Process;
Var     i:longint;
Begin
        read(n,t);
        if n mod 2=1 then
        begin
                if (n div 2) mod 2=0 then t:=t-(n div 2)-1
                else t:=t+(n div 2)+1;
        end;
        n:=n div 2;
        if n mod 2=0 then t:=t+n else t:=t+n-1-n*2;
        write(t);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
