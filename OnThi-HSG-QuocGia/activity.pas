Const   ginp='activity.inp';
        gout='activity.out';
        maxn=1000001;

Var     n,pr,cou:longint;
        a,b,pos,f,trace,q,o:array[0..maxn] of longint;

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
                        tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
                        tmp:=pos[i]; pos[i]:=pos[j]; pos[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                readln(a[i],b[i]);
                pos[i]:=i;
        end;
        sort(1,n);
End;

Procedure Update(i,p:longint);
Begin
        if i>maxn then exit;
        if f[q[i]]<f[p] then
        begin
                q[i]:=p;
                update(i+i and (-i),p);
        end;
End;

Function Quece(i:longint):longint;
Var     p:longint;
Begin
        if i<1 then exit(0);
        p:=quece(i-i and (-i));
        if f[q[i]]<f[p] then quece:=p else quece:=q[i];
End;

Procedure Process;
Var     i,p:longint;
Begin
        pr:=0; f[0]:=0;
        for i:=1 to n do
        begin
                p:=quece(a[i]);
                f[i]:=f[p]+1; trace[i]:=p;
                if f[i]>f[pr] then pr:=i;
                update(b[i],i);
        end;
        p:=pr; cou:=0;
        while p>0 do
        begin
                inc(cou); o[cou]:=p;
                p:=trace[p];
        end;
        writeln(cou);
        for i:=cou downto 1 do writeln(pos[o[i]]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
