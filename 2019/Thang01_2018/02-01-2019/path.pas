Const   ginp='path.inp';
        gout='path.out';
        maxn=100010;

Type    edge= record x,y,link:longint; end;

Var     n,m:longint;
        e:array[0..maxn] of edge;
        head,d:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        with e[i] do
        begin
                readln(x,y);
                link:=head[x];
                head[x]:=i;
        end;
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if d[y]=0 then
                begin
                        d[y]:=u;
                        dfs(y);
                end;
                i:=link;
        end;
End;

Procedure Process;
Var     u,cou:longint;
        ou:array[0..maxn] of longint;
Begin
        fillchar(d,sizeof(d),0);
        d[1]:=-1; dfs(1);
        cou:=0; u:=n;
        while u<>-1 do
        begin
                inc(cou);
                ou[cou]:=u;
                u:=d[u];
        end;
        for u:=cou downto 1 do write(ou[u],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
