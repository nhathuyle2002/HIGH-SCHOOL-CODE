Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';
        maxn=1000010;

Var     n,res:longint;
        a,f,id,cou:array[0..maxn] of longint;
        ans:array[0..maxn] of array of longint;

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
        readln(n);
        for i:=1 to n do read(a[i]);
        sort(1,n);
End;

Procedure Process;
Var     i,j:longint;
Begin
        fillchar(f,sizeof(f),0);
        res:=0;
        for i:=1 to n do
        begin
                for j:=1 to trunc(sqrt(a[i])) do
                        if a[i] mod j=0 then
                                f[a[i]]:=max(f[a[i]],max(f[j],f[a[i] div j])+1);
                res:=max(res,f[a[i]]);
                id[i]:=f[a[i]]; inc(cou[id[i]]);
        end;
        writeln(res);
        for i:=1 to res do
        begin
                setlength(ans[i],cou[i]+1);
                ans[i,0]:=0;
        end;
        for i:=1 to n do
        begin
                inc(ans[id[i],0]);
                ans[id[i],ans[id[i],0]]:=a[i];
        end;
        for i:=1 to res do
        begin
                write(cou[i],' ');
                for j:=1 to cou[i] do write(ans[i,j],' ');
                writeln;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
