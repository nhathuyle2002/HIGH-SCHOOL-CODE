Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';

Var     n,res:longint;
        a:string[100];

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        read(a);
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        for i:=1 to n do
                if a[i]='8' then inc(res);
        res:=min(res,n div 11);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
