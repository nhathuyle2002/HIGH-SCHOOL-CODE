Const   ginp='lines.inp';
        gout='lines.out';
        maxn=100001;

Var     n,pr,cou:longint;
        a,pb,trace,q,f,o:array[0..maxn] of longint;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]); readln;
        for i:=1 to n do
        begin
                read(x);
                pb[x]:=i;
        end;
End;

Function Quece(i:longint):longint;
Var     p:longint;
Begin
        if i<1 then exit(0);
        p:=quece(i-i and (-i));
        if f[q[i]]<f[p] then quece:=p else quece:=q[i];
End;

Procedure Update(i,p:longint);
Begin
        if i>n then exit;
        if f[q[i]]<f[p] then
        begin
                q[i]:=p;
                update(i+i and (-i),p);
        end;
End;

Procedure Process;
Var     i,p:longint;
Begin
        pr:=0; f[0]:=0;
        for i:=1 to n do
        begin
                p:=quece(pb[a[i]]);
                f[i]:=f[p]+1; trace[i]:=p;
                if f[i]>f[pr] then pr:=i;
                update(pb[a[i]],i);
        end;
        p:=pr;
        while p>0 do
        begin
                inc(cou); o[cou]:=p;
                p:=trace[p];
        end;
        writeln(cou);
        for i:=cou downto 1 do write(a[o[i]],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
