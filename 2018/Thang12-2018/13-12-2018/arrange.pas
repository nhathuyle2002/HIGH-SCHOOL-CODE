Const   ginp='arrange.inp';
        gout='arrange.out';
        maxn=1000010;

Var     n:longint;
        a:array[0..maxn] of longint;
        res:int64;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]>t do inc(i);
                while a[j]<t do dec(j);
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
        readln(n);
        for i:=1 to n do read(a[i]);
        sort(1,n);
End;

Procedure Process;
Var     i:longint;
        sum,thg,du:int64;
Begin
        res:=0; sum:=0;
        for i:=1 to n do sum:=sum+a[i];
        thg:=sum div n; du:=sum mod n;
        for i:=1 to n do
                if (i<=du) and (a[i]>thg+1) then res:=res+a[i]-thg-1 else
                if (i>du) and (a[i]>thg) then res:=res+a[i]-thg;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
