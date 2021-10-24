Const   ginp='kfib.inp';
        gout='kfib.out';
        maxn=50000000;

Var     st,r1,r2,m:longint;

Procedure Enter;
Var     i,a,b,c:longint;
Begin
        readln(m,r1,r2);
        a:=0; b:=1 mod m;
        if (a=r1) and (b=r2) then
        begin
                writeln(0);
                exit;
        end;
        for i:=1 to maxn do
        begin
                c:=(a+b) mod m;
                a:=b; b:=c;
                if (a=r1) and (b=r2) then
                begin
                        writeln(i);
                        exit;
                end;
        end;
        writeln(-1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do Enter;
        Close(input); Close(output);
End.
