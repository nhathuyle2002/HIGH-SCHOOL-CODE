Const   ginp='ss.inp';
        gout='ss.out';

Var     st:longint;
        n,v,l,r:int64;

Procedure Process;
Var     i:longint;
Begin
        readln(st);
        for i:=1 to st do
        begin
                readln(n,v,l,r);
                writeln(n div v-r div v+(l-1) div v);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
