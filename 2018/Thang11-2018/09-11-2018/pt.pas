Const   ginp='pt.inp';
        gout='pt.out';

Var     n:int64;
        st,cou:longint;
        x,y:array[0..1000001] of int64;

Procedure Process;
Var     i:longint;
Begin
        readln(n);
        cou:=0;
        while n>0 do
        begin
                inc(cou); x[cou]:=1; y[cou]:=1;
                while n mod 2=0 do
                begin
                        x[cou]:=x[cou]*2;
                        n:=n div 2;
                end;
                while n>=y[cou] do
                        y[cou]:=y[cou]*3;
                y[cou]:=y[cou] div 3; n:=n-y[cou];
        end;
        write(cou,' ');
        x[0]:=1;
        for i:=1 to cou do
        begin
                x[i]:=x[i-1]*x[i];
                write(x[i]*y[i],' ');
        end;
        writeln;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do Process;
        Close(input); Close(output);
End.
