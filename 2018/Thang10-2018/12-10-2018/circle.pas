Const   ginp='circle.inp';
        gout='circle.out';
        maxn=1000010;

Var     n,sl:longint;
        y,deg,root,leaf:array[0..maxn] of longint;
        d:array[0..maxn] of boolean;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(y[i]);
                inc(deg[y[i]]);
        end;
        fillchar(d,sizeof(d),true);
End;

Function Dfs(u:longint):longint;
Begin
        dfs:=u;
        d[u]:=false;
        if d[y[u]] then dfs:=dfs(y[u]);
End;

Procedure Process;
Var     i:longint;
Begin
        for i:=1 to n do
                if deg[i]=0 then
                begin
                        inc(sl);
                        root[sl]:=i; leaf[sl]:=dfs(i);
                end;
        for i:=1 to n do
                if d[i] then
                begin
                        inc(sl);
                        root[sl]:=i; leaf[sl]:=dfs(i);
                end;
        if (sl=1) and (y[leaf[1]]=root[1]) then
        begin
                write(0);
                exit;
        end;
        writeln(sl);
        root[sl+1]:=root[1];
        for i:=1 to sl do writeln(leaf[i],' ',root[i+1]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
