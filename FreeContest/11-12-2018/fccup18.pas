Const   ginp='fccup18.inp';
        gout='fccup18.out';

Var     n,a1,b1,a2,b2:longint;

Procedure Enter;
Begin
        readln(a1,b1);
        read(b2,a2);
End;

Procedure Process;
Var     i:longint;
Begin
        if a1+a2<>b1+b2 then
        begin
                if a1+a2>b1+b2 then write('A wins')
                else write('B wins');
        end else
        begin
                if a2>b1 then write('A wins') else
                if a2<b1 then write('B wins') else
                write('Extra time');
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
