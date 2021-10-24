Const   ginp='tours.inp';
        gout='tours.out';
        maxn=20010;

Var     n,m,res,cou:longint;
        x,y,link:array[-maxn..maxn] of longint;
        d:array[-maxn..maxn] of boolean;
        head,pa,deep,ou:array[0..maxn] of longint;

Procedure Add(i,u,v:longint);
Begin
        x[i]:=u; y[i]:=v;
        link[i]:=head[u];
        d[i]:=true;
        head[u]:=i;
End;

Procedure Dfs(u:longint);
Var     i,v:longint;
Begin
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if pa[v]=0 then
                begin
                        pa[v]:=u; deep[v]:=deep[u]+1;
                        d[i]:=false; d[-i]:=false;
                        dfs(v);
                end;
                i:=link[i];
        end;
End;

Procedure Answer(u,v:longint);
Var     i:longint;
Begin
        cou:=1; ou[1]:=u;
        while deep[u]>deep[v] do
        begin
                write(u,' ');
                u:=pa[u];
        end;
        while u<>v do
        begin
                write(u,' ');
                inc(cou); ou[cou]:=v;
                u:=pa[u]; v:=pa[v];
        end;
        write(u,' ');
        for i:=cou downto 1 do write(ou[i],' ');
End;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
End;

Procedure Process;
Var     u,i:longint;
Begin
        res:=m-n;
        for u:=1 to n do
                if pa[u]=0 then
                begin
                        inc(res);
                        pa[u]:=-1; deep[u]:=1;
                        dfs(u);
                end;
        writeln(res);
        {for i:=1 to m do
                if d[i] then
                begin
                        if deep[x[i]]>deep[y[i]] then answer(x[i],y[i])
                        else answer(y[i],x[i]);
                        writeln;
                end;}
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
