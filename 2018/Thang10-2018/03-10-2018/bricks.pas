Const   ginp='bricks.inp';
        gout='bricks.out';

Var     s,p,m,n:int64;

Procedure Enter;
Var     i:longint;
Begin
        read(s,p);
        s:=s-4;
End;

Procedure Process;
Var     i:longint;
Begin
        m:=(s div 2-trunc(sqrt(s*s div 4-4*p))) div 2;
        n:=(s div 2+trunc(sqrt(s*s div 4-4*p))) div 2;
        write(m+2,' ',n+2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
