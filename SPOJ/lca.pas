const   ginp='ss.inp';
        gout='ss.out';
        maxn=1001;
        maxk=10;

var     gi,go:text;
        n,st,fst:longint;
        y,link,head,h:array[0..maxn] of longint;
        p:array[0..maxn,0..maxk] of longint;

procedure dfs(u:longint);
var     i,v:longint;
begin
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                h[v]:=h[u]+1;
                dfs(v);
                i:=link[i];
        end;
end;

function lca(u,v:longint):longint;
var     i:longint;
begin
        for i:=maxk downto 0 do
                if h[p[u,i]]>=h[v] then u:=p[u,i];
        if u=v then exit(u);
        for i:=maxk downto 0 do
                if p[u,i]<>p[v,i] then
                begin
                        u:=p[u,i];
                        v:=p[v,i];
                end;
        exit(p[u,0]);
end;

procedure input;
var     i,m,k,j:longint;
begin
        readln(gi,n);
        k:=0;
        for i:=1 to n do
        begin
                head[i]:=0;
                p[i,0]:=i;
        end;
        for i:=1 to n do
        begin
                read(gi,m);
                for j:=1 to m do
                begin
                        inc(k);read(gi,y[k]);
                        p[y[k],0]:=i;
                        link[k]:=head[i];head[i]:=k;
                end;
                readln(gi);
        end;
end;

procedure output;
var     i,j,q,u,v:longint;
begin
        for i:=1 to n do
                if p[i,0]=i then u:=i;
        h[u]:=1;dfs(u);
        for j:=1 to maxk do
                for i:=1 to n do
                        p[i,j]:=p[p[i,j-1],j-1];
        writeln(go,'Case ',fst,':');
        readln(gi,q);
        for i:=1 to q do
        begin
                readln(gi,u,v);
                if h[u]<h[v] then writeln(go,lca(v,u))
                else writeln(go,lca(u,v));
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        readln(gi,st);
        for fst:=1 to st do
        begin
                input;
                output;
        end;
        close(gi);close(go);
end.
