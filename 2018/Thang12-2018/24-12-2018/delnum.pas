Const   ginp='delnum.inp';
        gout='delnum.out';
        maxn=100001;

Var     n,top:longint;
        a,d,q:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i]);
                d[i]:=0;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        top:=1; q[1]:=1; d[1]:=1;
        for i:=2 to n do
        begin
                while (a[i]>a[q[top]]) and (d[q[top]]=0) do dec(top);
                if (a[i]=a[q[top]]) or ((d[q[top]]=1) and (a[i]>a[q[top]])) then d[i]:=1;
                inc(top); q[top]:=i;
        end;
        write(top);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
