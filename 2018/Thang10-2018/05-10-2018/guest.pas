Uses    Math;

Const   ginp='guest.inp';
        gout='guest.out';
        maxn=100010;

Var     n,root,cou:longint;
        a,link,head,y,ou:array[0..maxn] of longint;
        f:array[0..maxn,0..1] of int64;

Procedure Enter;
Var     i,pa:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                readln(pa,a[i]);
                if pa=0 then
                begin
                        root:=i;
                        continue;
                end;
                y[i]:=i;
                link[i]:=head[pa];
                head[pa]:=i;
        end;
End;

Procedure Dfs(u:longint);
Var     i,v:longint;
Begin
        f[u,1]:=a[u]; f[u,0]:=0;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                dfs(v);
                f[u,1]:=f[u,1]+f[v,0];
                f[u,0]:=f[u,0]+max(f[v,0],f[v,1]);
                i:=link[i];
        end;
End;

Procedure Answer(u,k:longint);
Var     i,v:longint;
Begin
        if k=1 then
        begin
                inc(cou); ou[cou]:=u;
        end;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if k=1 then answer(v,0) else
                if f[v,0]>f[v,1] then answer(v,0) else answer(v,1);
                i:=link[i];
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        dfs(root);
        cou:=0;
        if f[root,0]<f[root,1] then answer(root,1) else answer(root,0);
        writeln(cou,' ',max(f[root,1],f[root,0]));
        for i:=1 to cou do writeln(ou[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
