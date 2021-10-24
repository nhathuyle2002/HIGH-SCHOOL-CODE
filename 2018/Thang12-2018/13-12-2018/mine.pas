Uses    Math;

Const   ginp='mine.inp';
        gout='mine.out';
        maxn=100010;

Var     n,cou:longint;
        x,g,w:array[0..maxn] of int64;
        d1,d2:array[0..maxn] of longint;
        res:int64;
        f:array[0..2*maxn] of longint;

Procedure Sort(l,r:longint; var d:array of int64; var p:array of longint);
Var     i,j,tt:longint;
        t,tmp:int64;
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
                        tt:=p[i]; p[i]:=p[j]; p[j]:=tt;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d,p); sort(i,r,d,p);
End;

Procedure Enter;
Var     i:longint;
        d:array[0..2*maxn] of int64;
        p:array[0..2*maxn] of longint;
Begin
        readln(n);
        g[0]:=0;
        for i:=1 to n do
        begin
                readln(x[i],w[i],g[i]);
                g[i]:=g[i-1]+g[i];
                w[i]:=w[i-1]+w[i];
                d[i]:=g[i]-x[i]; p[i]:=i;
                d[i+n]:=-x[i]+g[i-1]; p[i+n]:=i+n;
        end;
        sort(1,2*n,d,p);
        cou:=0; d[0]:=-trunc(1e15);
        for i:=1 to 2*n do
        begin
                if d[i]>d[i-1] then inc(cou);
                if p[i]<=n then d1[p[i]]:=cou
                else d2[p[i]-n]:=cou;
        end;
End;

Function Quece(i:longint):longint;
Begin
        if i<1 then exit(n+1);
        quece:=min(f[i],quece(i-i and (-i)));
End;

Procedure Update(i,x:longint);
Begin
        if i>cou then exit;
        if f[i]>x then
        begin
                f[i]:=x;
                update(i+i and (-i),x);
        end;
End;

Procedure Process;
Var     i,p:longint;
Begin
        for i:=1 to cou do f[i]:=n+1;
        res:=0;
        for i:=1 to n do
        begin
                update(d2[i],i);
                p:=quece(d1[i]);
                res:=max(res,w[i]-w[p-1]);
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
