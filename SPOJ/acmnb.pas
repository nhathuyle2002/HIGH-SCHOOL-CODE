Const   ginp='ss.inp';
        gout='ss.out';
        maxn=4*100010;

Var     n:longint;
        res:int64;
        a,b:array[0..2*maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=random(r-l+1)+l;
        t:=a[t]-b[t];
        repeat
                while a[i]-b[i]<t do inc(i);
                while a[j]-b[j]>t do dec(j);
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
        for i:=1 to 2*n do readln(a[i],b[i]);
        sort(1,2*n);
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        for i:=1 to n do res:=res+a[i];
        for i:=n+1 to 2*n do res:=res+b[i];
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
