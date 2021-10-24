Const   ginp='wedding.inp';
        gout='wedding.out';
        maxn=2010;

Var     n:longint;
        d:array[0..2*maxn,0..2*maxn] of longint;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(n);
        for i:=1 to 2*n do
        begin
                while not seekeoln do
                begin
                        read(x);
                        d[i,x]:=1; d[x,i]:=1;
                end;
                readln;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
