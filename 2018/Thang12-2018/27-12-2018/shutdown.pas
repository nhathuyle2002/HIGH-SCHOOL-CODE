Uses    Math;

Const   ginp='shutdown.inp';
        gout='shutdown.out';
        maxn=501;
        maxg=18;

Type    edge= record y,link:longint; end;

Var     m,n,k,coue:longint;
        e:array[0..maxn*maxn*4] of edge;
        head:array[0..maxn*maxn] of longint;
        a:array[0..maxn,0..maxn] of longint;
        root,h:array[0..maxn*maxn] of longint;
        d:array[0..maxn*maxn,0..4] of longint;
        pa,fg:array[0..maxn*maxn,0..maxg] of longint;

Procedure Enter;
Var     i,j,x:longint;
Begin
        readln(m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
        for i:=1 to m do
                for j:=1 to n do
                begin
                        x:=a[i,j];
                        root[x]:=x;
                        d[x,1]:=a[i-1,j];
                        d[x,2]:=a[i,j-1];
                        d[x,3]:=a[i+1,j];
                        d[x,4]:=a[i,j+1];
                end;
End;

Procedure Adde(u,v:longint);
Begin
        inc(coue);
        with e[coue] do
        begin
                y:=v;
                link:=head[u];
        end;
        head[u]:=coue;
End;

Function Add(u,v:longint):boolean;
Var     u0,v0:longint;
Begin
        u0:=u;
        while root[u0]<>u0 do u0:=root[u0];
        v0:=v;
        while root[v0]<>v0 do v0:=root[v0];
        if u0<>v0 then
        begin
                add:=true;
                if h[v0]<h[u0] then
                begin
                        root[v0]:=u0; root[u]:=u0; root[v]:=u0;
                end else
                begin
                        root[u0]:=v0; root[u]:=v0; root[v]:=v0;
                        h[v0]:=max(h[v0],h[u0]+1);
                end;
        end else
        begin
                add:=false;
                root[u]:=u0; root[v]:=v0;
        end;
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        fg[u,0]:=u;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if pa[y,0]=0 then
                begin
                        pa[y,0]:=u; h[y]:=h[u]+1;
                        dfs(y);
                end;
                i:=link;
        end;
End;

Function Lca(u,v:longint):longint;
Var     j:longint;
Begin
        if h[u]<h[v] then
        begin
                j:=u; u:=v; v:=j;
        end;
        lca:=v;
        for j:=maxg downto 0 do
                if h[pa[u,j]]>=h[v] then
                begin
                        lca:=min(lca,fg[u,j]);
                        u:=pa[u,j];
                end;
        if u=v then exit(lca);
        for j:=maxg downto 0 do
                if pa[u,j]<>pa[v,j] then
                begin
                        lca:=min(lca,min(fg[u,j],fg[v,j]));
                        u:=pa[u,j];
                        v:=pa[v,j];
                end;
        lca:=min(lca,min(fg[u,0],fg[v,0]));
End;

Procedure Process;
Var     i,j,x,y:longint;
Begin
        coue:=0;
        for i:=m*n downto 1 do
                for j:=1 to 4 do
                        if (d[i,j]>i) and (add(i,d[i,j])) then
                        begin
                                adde(i,d[i,j]);
                                adde(d[i,j],i);
                        end;
        h[1]:=0; pa[1,0]:=1; dfs(1);
        for j:=1 to maxg do
                for i:=1 to m*n do
                begin
                        pa[i,j]:=pa[pa[i,j-1],j-1];
                        fg[i,j]:=min(fg[pa[i,j-1],j-1],fg[i,j-1]);
                end;
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
