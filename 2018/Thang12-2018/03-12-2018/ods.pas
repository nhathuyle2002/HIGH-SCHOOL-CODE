Const   ginp='ods.inp';
        gout='ods.out';

Var     st,a,b:longint;
        m2:array[0..30] of longint;

Procedure Enter;
Var     i:longint;
Begin
        m2[0]:=1;
        for i:=1 to 30 do m2[i]:=m2[i-1]*2;
End;

Function Get(x:longint):int64;
Var     i,k:longint;
Begin
        get:=0;
        for i:=0 to 30 do
        begin
                k:=x div m2[i];
                if k mod 2=0 then dec(k);
                get:=get+int64(k+1)*(k div 2+1) div 2;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        readln(st);
        for i:=1 to st do
        begin
                readln(a,b);
                writeln(get(b)-get(a-1));
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
