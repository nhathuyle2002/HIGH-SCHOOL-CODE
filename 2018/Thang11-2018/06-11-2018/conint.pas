Uses    Math;

Const   ginp='conint.inp';
        gout='conint.out';
        maxn=100010;

Var     n,res:longint;
        a,b:array[0..maxn] of longint;
        d:array[-maxn..maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(a[i],b[i]);
        sort(1,n);
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        for i:=1 to n do
        begin
                d[b[i]]:=max(d[b[i]],d[a[i]]+1);
                res:=max(res,d[b[i]]);
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
