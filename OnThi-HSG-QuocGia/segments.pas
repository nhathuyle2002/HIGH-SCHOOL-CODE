Const   ginp='segments.inp';
        gout='segments.out';
        maxn=100010;

Var     n,m,cou:longint;
        a,b,x:array[0..maxn] of longint;
        c:array[0..3*maxn] of longint;

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
Var     i,tmp:longint;
        d,p:array[0..3*maxn] of longint;
Begin
        readln(n,m);
        for i:=1 to n do
        begin
                readln(a[i],b[i]);
                if a[i]>b[i] then
                begin
                        tmp:=a[i]; a[i]:=b[i]; b[i]:=tmp;
                end;
                inc(b[i]);
                d[i]:=a[i]; p[i]:=i;
                d[i+n]:=b[i]; p[i+n]:=i+n;
        end;
        for i:=1 to m do
        begin
                read(x[i]);
                d[i+2*n]:=x[i]; p[i+2*n]:=i+2*n;
        end;
        sort(1,2*n+m,d,p);
        d[0]:=-trunc(1e9)-100;
        cou:=0;
        for i:=1 to 2*n+m do
        begin
                if d[i]>d[i-1] then inc(cou);
                if p[i]<=n then a[p[i]]:=cou else
                if p[i]<=2*n then b[p[i]-n]:=cou else
                x[p[i]-2*n]:=cou;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        for i:=1 to n do
        begin
                inc(c[a[i]]); dec(c[b[i]]);
        end;
        for i:=1 to cou do c[i]:=c[i-1]+c[i];
        for i:=1 to m do write(c[x[i]],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
