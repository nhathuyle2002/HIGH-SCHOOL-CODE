Const   ginp='bonus.inp';
        gout='bonus.out';
        maxn=1001;

Var     n,cou:longint;
        sum,res:int64;
        a,d:array[0..maxn*maxn] of int64;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t,tmp:int64;
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
Var     i,j,x:longint;
Begin
        readln(n);
        x:=0; sum:=0;
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        inc(x); read(a[x]);
                        sum:=sum+a[x];
                end;
                readln;
        end;
        n:=x;
        sort(1,n);
End;

Procedure Process;
Var     i,cou:longint;
Begin
        a[0]:=0; cou:=0;
        for i:=1 to n do
                if a[i]=a[cou] then inc(d[cou]) else
                begin
                        inc(cou);
                        a[cou]:=a[i]; d[cou]:=1;
                end;
        res:=0;
        for i:=1 to cou do
                if sum-d[i]*a[i]>res then res:=sum-d[i]*a[i];
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
