Const   ginp='lottery.inp';
        gout='lottery.out';
        maxn=1000010;

Var     n,gr,cr:longint;
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
        readln(n,res);
        res:=res*n;
        for i:=1 to n do readln(a[i]);
        sort(1,n);
End;

Procedure Process;
Var     i,cou:longint;
Begin
        gr:=0; cr:=n+1; cou:=0;
        a[0]:=a[1]; a[n+1]:=a[n]+1;
        for i:=1 to n+1 do
                if a[i]=a[i-1] then inc(cou) else
                begin
                        if cou<=cr then
                        begin
                                cr:=cou;
                                gr:=a[i-1];
                        end;
                        cou:=1;
                end;
        res:=res-int64(gr)*cr;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
