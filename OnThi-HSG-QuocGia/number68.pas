Const   ginp='number68.inp';
        gout='number68.out';

Var     n,p8:longint;
        a:ansistring;

Procedure Enter;
Begin
        readln(a);
        n:=length(a);
End;

Procedure Process;
Var     i,j:longint;
Begin
        p8:=0;
        for i:=1 to n do
                if a[i]>'8' then
                begin
                        for j:=1 to i-1 do write(a[j]);
                        for j:=i to n do write('8');
                        exit;
                end else
                if a[i]='8' then p8:=i else
                if a[i]='7' then
                begin
                        for j:=1 to i-1 do write(a[j]);
                        write('6');
                        for j:=i+1 to n do write('8');
                        exit;
                end else
                if a[i]<'6' then
                begin
                        if p8=0 then
                        for j:=1 to n-1 do write('8') else
                        begin
                                for j:=1 to p8-1 do write(a[j]);
                                write('6');
                                for j:=p8+1 to n do write('8');
                        end;
                        exit;
                end;
        write(a);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
