Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';

Var     n,sum,i,x,gmax:longint;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(n);
        sum:=0; gmax:=0;
        for i:=1 to n do
        begin
                read(x);
                gmax:=max(gmax,x);
                sum:=sum+x;
        end;
        write(max(2*sum div n+1,gmax));
        Close(input); Close(output);
End.
