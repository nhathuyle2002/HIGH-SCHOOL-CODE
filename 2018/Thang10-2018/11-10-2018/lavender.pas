Const   ginp='lavender.inp';
        gout='lavender.out';

Var     n:longint;
        res,t,m:int64;
        p:array[0..100010] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m,t);
        for i:=1 to n do read(p[i]);
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        for i:=1 to n do
                res:=res+(t div m)*(m div p[i])+t mod m div p[i];
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
