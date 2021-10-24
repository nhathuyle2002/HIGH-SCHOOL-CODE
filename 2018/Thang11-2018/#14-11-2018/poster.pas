Const   ginp='poster.inp';
        gout='poster.out';
        maxn=250010;

Var     n,top,res:longint;
        d,h,q:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(d[i],h[i]);
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        top:=0; q[0]:=0; h[0]:=0;
        for i:=1 to n do
        begin
                while (top>0) and (h[i]<h[q[top]]) do dec(top);
                if h[i]>h[q[top]] then inc(res);
                inc(top); q[top]:=i;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
