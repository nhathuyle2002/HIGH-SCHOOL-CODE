Const   ginp='walk.inp';
        gout='walk.out';
        maxn=300001;

Var     n,md:longint;
        res:int64;
        a:array[0..maxn] of longint;

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
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,md);
        for i:=1 to n do read(a[i]);
        sort(1,n);
End;

Procedure Process;
Var     i,j:longint;
Begin
        res:=0;
        j:=1;
        for i:=1 to n do
        begin
                while (j<=n) and (a[j]-a[i]<=md) do inc(j);
                res:=res+n-j+1;
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
