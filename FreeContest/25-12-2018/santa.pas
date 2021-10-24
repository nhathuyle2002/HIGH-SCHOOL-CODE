Const   ginp='';//santa.inp';
        gout='';//santa.out';

Var     n:longint;
        c:array[0..1] of longint;
        res:int64;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(x);
                inc(c[x]);
        end;
End;

Procedure Process;
Begin
        res:=int64(c[0])*(c[0]-1)+int64(c[1])*(c[1]-1);
        write(res div 2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
