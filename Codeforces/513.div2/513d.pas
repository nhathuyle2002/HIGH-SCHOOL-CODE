Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';

Var     n:longint;
        res:int64;
        a,b:array[0..100010] of longint;

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

Procedure Process;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(a[i],b[i]);
        sort(1,n,a); sort(1,n,b);
        res:=0;
        for i:=1 to n do res:=res+max(a[i],b[i])+1;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
