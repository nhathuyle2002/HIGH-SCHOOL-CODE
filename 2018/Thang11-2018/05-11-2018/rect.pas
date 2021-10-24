Uses    Math;

Const   ginp='rect.inp';
        gout='rect.out';
        maxn=1000010;

Var     n,m,top:longint;
        res:int64;
        a,q,pl,pr:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(m,n);
        for i:=1 to n do read(a[i]);
End;

Procedure Process;
Var     i,st:longint;
Begin
        res:=0;
        for st:=1 to 2 do
        begin
                for i:=1 to n do pr[i]:=n+1;
                top:=0;
                for i:=1 to n do
                begin
                        while (top>0) and (a[i]<a[q[top]]) do
                        begin
                                pr[q[top]]:=i;
                                dec(top);
                        end;
                        if a[q[top]]<a[i] then pl[i]:=q[top] else pl[i]:=pl[q[top]];
                        inc(top); q[top]:=i;
                end;
                for i:=1 to n do res:=max(res,int64(a[i])*(pr[i]-pl[i]-1));
                for i:=1 to n do a[i]:=m-a[i];
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
