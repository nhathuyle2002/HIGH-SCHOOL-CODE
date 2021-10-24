Const   ginp='permutation.inp';
        gout='permutation.out';

Var     n:longint;
        a,res:array[0..1010] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
End;

Procedure Process;
Var     i,j:longint;
Begin
        res[1]:=n;
        for i:=n-1 downto 1 do
        begin
                for j:=n-i downto a[i]+1 do res[j+1]:=res[j];
                res[a[i]+1]:=i;
        end;
        for i:=1 to n do write(res[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
