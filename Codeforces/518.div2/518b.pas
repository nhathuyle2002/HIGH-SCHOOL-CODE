Const   ginp='ss.inp';
        gout='ss.out';

Var     n,res:int64;

Procedure Enter;
Begin
        read(n);
End;

Procedure Process;
Var     i,cou:longint;
Begin
        res:=1;
        i:=2;
        while i<=sqrt(n) do
        begin
                cou:=0;
                while n mod i=0 do
                begin
                        inc(cou);
                        n:=n div i;
                end;
                res:=res*(cou+1);
                inc(i);
        end;
        if n>1 then res:=res*2;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
