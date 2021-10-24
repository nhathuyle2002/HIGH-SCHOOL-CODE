Const   ginp='treeline.inp';
        gout='treeline.out';

Var     n,res,top:longint;
        a,q,f:array[0..1000010] of longint;

Function Max(x,y:longint):longint;
Begin
        if x>y then max:=x else max:=y;
End;

Procedure Process;
Var     i,cou:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
        res:=0; top:=0;
        for i:=n downto 1 do
        begin
                cou:=0; f[i]:=0;
                while (top>0) and (a[i]>=a[q[top]]) do
                begin
                        inc(cou); f[i]:=max(f[i]+1,max(f[q[top]],cou));
                        dec(top);
                end;
                res:=max(res,f[i]);
                inc(top); q[top]:=i;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
