Const   ginp='kite.inp';
        gout='kite.out';
        maxn=100010;

Var     n,cou:longint;
        f,h:array[0..maxn] of longint;

Procedure Sort(l,r:longint; var d,p:array of longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]>t do inc(i);
                while t>d[j] do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        tmp:=p[i]; p[i]:=p[j]; p[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d,p); sort(i,r,d,p);
End;

Procedure Update(i,x:longint);
Begin
        if i>cou then exit;
        f[i]:=f[i]+x;
        update(i+i and (-i),x);
End;

Function Quece(i:longint):longint;
Begin
        if i<1 then exit(0);
        quece:=f[i]+quece(i-i and (-i));
End;

Procedure Enter;
Var     i:longint;
        d,p:array[0..maxn] of longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                readln(h[i]);
                d[i]:=h[i]; p[i]:=i;
        end;
        sort(1,n,d,p);
        cou:=0; d[0]:=-1;
        for i:=1 to n do
        begin
                if d[i]<>d[i-1] then inc(cou);
                h[p[i]]:=cou;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        for i:=1 to cou do f[i]:=0;
        for i:=1 to n do
        begin
                writeln(quece(h[i]-1)+1);
                update(h[i],1);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
