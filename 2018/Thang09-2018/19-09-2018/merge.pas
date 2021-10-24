Const   ginp='merge.inp';
        gout='merge.out';

Var     m,n:longint;
        a,b:array[0..100010] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(m,n);
        for i:=1 to m do read(a[i]); readln;
        for i:=1 to n do read(b[i]);
End;

Procedure Process;
Var     i,j:longint;
Begin
        j:=1;
        for i:=1 to m do
        begin
                while (j<=n) and (b[j]<=a[i]) do
                begin
                        write(b[j],' ');
                        inc(j);
                end;
                write(a[i],' ');
        end;
        for j:=j to n do write(b[j]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
