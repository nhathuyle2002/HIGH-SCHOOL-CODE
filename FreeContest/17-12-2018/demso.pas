Const   ginp='demso.inp';
        gout='demso.out';

Var     n,res1,res2:longint;
        s:ansistring;

Procedure Enter;
Begin
        readln(n);
        read(s); s:=' '+s; n:=length(s);
End;

Procedure Process;
Var     i:longint;
Begin
        res1:=0; res2:=0;
        for i:=1 to n-1 do
                if (s[i]=' ') and (s[i+1]>'0') and (s[i+1]<='9') then inc(res1) else
                if (s[i]='-') and (s[i+1]<>'0') then inc(res2);
        write(res2,' ',res1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
