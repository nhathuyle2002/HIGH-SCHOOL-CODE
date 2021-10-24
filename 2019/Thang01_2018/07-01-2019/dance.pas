Const   ginp='dance.inp';
        gout='dance.out';
        maxn=100010;

Var     m,n,res:longint;
        a,b:array[0..maxn] of longint;

Procedure Sort(l,r:longint; var d:array of longint);
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
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d); sort(i,r,d);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(m,n);
        for i:=1 to m do read(a[i]); readln;
        for i:=1 to n do read(b[i]);
        sort(1,m,a); sort(1,n,b);
End;

Procedure Process;
Var     i,j,cou:longint;
Begin
        res:=0; cou:=0;
        j:=1;
        for i:=1 to m do
        begin
                while (j<=n) and (a[i]>b[j]) do
                begin
                        inc(j); inc(cou);
                end;
                if cou>0 then
                begin
                        inc(res);
                        dec(cou);
                end;
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
