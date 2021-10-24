Const   ginp='change.inp';
        gout='change.out';
        n = 1000;
        d:array[1..6] of longint = (1,5,10,50,100,500);

Var     st:longint;
        f:array[0..n] of longint;

Procedure Enter;
Var     i,j:longint;

        Function Min(x,y:longint):longint;
        Begin
                if x<y then min:=x else min:=y;
        End;
Begin
        f[0]:=0;
        for i:=1 to n do
        begin
                f[i]:=i;
                for j:=1 to 6 do
                        if i<d[j] then break else
                        f[i]:=min(f[i],f[i-d[j]]+1);
        end;
End;

Procedure Process;
Var     i,x:longint;
Begin
        //readln(st);
        for i:=1 to 1 do
        begin
                readln(x);
                writeln(f[n-x]);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
