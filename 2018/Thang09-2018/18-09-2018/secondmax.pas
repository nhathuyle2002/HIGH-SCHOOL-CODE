Const   ginp='secondmax.inp';
        gout='secondmax.out';

Var     n,cou:longint;
        a:array[0..100010] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
End;

Procedure Process;
Var     i,ma1,ma2:longint;
Begin
        ma1:=0; ma2:=0;
        for i:=1 to n do
                if a[i]>ma1 then
                begin
                        ma2:=ma1; ma1:=a[i];
                end else
                if (a[i]<ma1) and (a[i]>ma2) then ma2:=a[i];
        writeln(ma2);
        if ma2>0 then
        for i:=1 to n do
                if a[i]=ma2 then write(i,' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
