Const   ginp='flower.inp';
        gout='flower.out';
        maxn=100010;

Var     n,del,res,cou:longint;
        a:array[0..maxn] of string[10];
        pos,x,c,d:array[0..maxn] of longint;

Procedure Sorta(l,r:longint);
Var     i,j,tt:longint;
        t,tmp:string[10];
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while t<a[j] do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        tt:=pos[i]; pos[i]:=pos[j]; pos[j]:=tt;
                        inc(i); dec(j);
                end;
        until i>j;
        sorta(l,j); sorta(i,r);
End;

Procedure Sortx(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=x[random(r-l+1)+l];
        repeat
                while x[i]<t do inc(i);
                while t<x[j] do dec(j);
                if i<=j then
                begin
                        tmp:=x[i]; x[i]:=x[j]; x[j]:=tmp;
                        tmp:=c[i]; c[i]:=c[j]; c[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sortx(l,j); sortx(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,del);
        for i:=1 to n do
        begin
                readln(x[i]);
                readln(a[i]);
                pos[i]:=i;
        end;
        sorta(1,n);
        a[0]:=''; cou:=0;
        for i:=1 to n do
        begin
                if a[i]<>a[i-1] then inc(cou);
                c[pos[i]]:=cou;
        end;
        sortx(1,n);
End;

Procedure Push(x:longint);
Begin
        if d[x]=0 then inc(cou);
        inc(d[x]);
End;

Procedure Pop(x:longint);
Begin
        dec(d[x]);
        if d[x]=0 then dec(cou);
End;

Procedure Process;
Var     i,j:longint;
Begin
        fillchar(d,sizeof(d),0);
        res:=0;
        j:=1; cou:=0;
        for i:=1 to n do
        begin
                if i>1 then pop(c[i-1]);
                while (j<=n) and (x[j]-x[i]<=del) do
                begin
                        push(c[j]);
                        inc(j);
                end;
                if res<cou then res:=cou;
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
