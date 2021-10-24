const   ginp='ss.inp';
        gout='ss.out';
        maxn=70005;
        maxk=18;

type    edge=record y,k:longint;d:boolean;end;

var     gi,go:text;
        n,q:longint;
        e:array[-maxn..maxn] of edge;
        head,h:array[0..maxn] of longint;
        f:array[0..maxn*4] of longint;
        p:array[0..maxn,0..maxk] of longint;

procedure add(i,u,v:longint);
begin
        with e[i] do
        begin
                y:=v;k:=head[u];
                d:=true;
        end;
        head[u]:=i;
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        i:=head[u];
        while i<>0 do
        begin
                if e[i].d then
                begin
                        e[-i].d:=false;
                        v:=e[i].y;
                        p[v,0]:=u;h[v]:=h[u]+1;
                        dfs(v);
                end;
                i:=e[i].k;
        end;
end;

function lca(u,v:longint):longint;
var     i:longint;
begin
        if u=-1 then exit(v);
        if v=-1 then exit(u);
        if h[u]<h[v] then
        for i:=maxk downto 0 do
                if h[p[v,i]]>=h[u] then v:=p[v,i];
        if h[u]>h[v] then
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

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                f[id]:=l;
                exit;
        end;
        m:=(l+r) shr 1;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
        f[id]:=lca(f[id*2],f[id*2+1]);
end;

function quece(id,l,r,d,c:longint):longint;
var     m:longint;
begin
        if (c<l) or (r<d) then exit(-1);
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) shr 1;
        quece:=lca(quece(id*2,l,m,d,c),quece(id*2+1,m+1,r,d,c));
end;

procedure input;
var     i,u,v,j:longint;
begin
        readln(gi,n,q);
        for i:=1 to n-1 do
        begin
                readln(gi,u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
        p[1,0]:=1;h[1]:=1;dfs(1);
        for j:=1 to maxk do
                for i:=1 to n do
                        p[i,j]:=p[p[i,j-1],j-1];
end;

procedure process;
var     i,u,v:longint;
begin
        build(1,1,n);
        for i:=1 to q do
        begin
                readln(gi,u,v);
                writeln(go,quece(1,1,n,u,v));
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
