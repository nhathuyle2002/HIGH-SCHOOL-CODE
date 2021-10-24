Const   ginp='rendezvous.inp';
        gout='rendezvous.out';
        maxn=200001;
        maxg=18;

Type    edge= record y,link:longint; end;

Var     n,k:longint;
        e:array[-maxn..maxn] of edge;
        head,h:array[0..maxn] of longint;
        pa:array[0..maxn,0..maxg] of longint;

Procedure Add(i,u,v:longint);
Begin
        with e[i] do
        begin
                y:=v;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n,k);
        for i:=1 to n-1 do
        begin
                readln(u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if pa[y,0]=0 then
                begin
                        pa[y,0]:=u;
                        h[y]:=h[u]+1;
                        dfs(y);
                end;
                i:=link;
        end;
End;

Function Lca(u,v:longint):longint;
Var     i:longint;
Begin
        if h[u]<h[v] then
        begin
                i:=u; u:=v; v:=i;
        end;
        for i:=maxg downto 0 do
                if h[pa[u,i]]>=h[v] then u:=pa[u,i];
        if u=v then exit(u);
        for i:=maxg downto 0 do
                if pa[u,i]<>pa[v,i] then
                begin
                        u:=pa[u,i];
                        v:=pa[v,i];
                end;
        exit(pa[u,0]);
End;

Procedure Process;
Var     u,i,x,y:longint;
Begin
        pa[1,0]:=1; dfs(1);
        for i:=1 to maxg do
                for u:=1 to n do
                        pa[u,i]:=pa[pa[u,i-1],i-1];
        for i:=1 to k do
        begin
                readln(x,y);
                writeln(lca(x,y));
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
