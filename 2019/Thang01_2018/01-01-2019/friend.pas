Const   ginp='friend.inp';
        gout='friend.out';
        maxn=200010;

Var     n,s:longint;
        res:int64;
        a,b,dd:array[0..maxn] of longint;

Procedure Sort(l,r:longint; var d,p:array of longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        tmp:=p[i]; p[i]:=p[j]; p[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d,p); sort(i,r,d,p);
End;

Procedure Enter;
Var     i,cou:longint;
        d,p:array[0..maxn] of longint;
Begin
        readln(n,s);
        for i:=1 to n do
        begin
                readln(a[i]);
                d[i]:=a[i]; p[i]:=i;
                d[i+n]:=s-a[i]; p[i+n]:=i+n;
        end;
        sort(1,2*n,d,p);
        cou:=0; d[0]:=-2*trunc(1e9)-100;
        for i:=1 to 2*n do
        begin
                if d[i]>d[i-1] then inc(cou);
                if p[i]<=n then a[p[i]]:=cou else b[p[i]-n]:=cou;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        fillchar(dd,sizeof(dd),0);
        res:=0;
        for i:=1 to n do
        begin
                res:=res+dd[b[i]];
                inc(dd[a[i]]);
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
