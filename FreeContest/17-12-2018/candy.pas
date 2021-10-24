Const   ginp='candy.inp';
        gout='candy.out';
        maxn=200010;

Var     n:longint;
        res:int64;
        s:array[0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(s[i]);
                s[i]:=s[i]+s[i-1];
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        res:=trunc(1e14);
        for i:=1 to n-1 do
                if res>abs(2*s[i]-s[n]) then res:=abs(2*s[i]-s[n]);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
