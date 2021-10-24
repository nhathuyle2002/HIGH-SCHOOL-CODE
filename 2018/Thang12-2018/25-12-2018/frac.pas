Const   ginp='frac.inp';
        gout='frac.out';

Var     n,ra,rb:longint;
        x:real;

Procedure Enter;
Begin
        readln(x);
        read(n);
End;

Procedure Process;
Var     a,b:longint;
Begin
        rb:=n;
        ra:=round(x*n);
        for b:=n-1 downto 1 do
        begin
                a:=round(x*b);
                if abs(a/b-x)<=abs(ra/rb-x) then
                begin
                        ra:=a;
                        rb:=b;
                end;
        end;
        write(ra,' ',rb);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
