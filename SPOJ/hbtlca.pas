const   ginp='ss.inp';
        gout='ss.out';
        maxn=100005;
        maxk=18;

type    edge=record y,k:longint;d:boolean;end;

var     gi,go:text;
        n,m,res,root:longint;
        e:array[-maxn..maxn] of edge;
        head,h:array[0..maxn] of longint;
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
                        v:=e[i].y;p[v,0]:=u;
                        h[v]:=h[u]+1;
                        dfs(v);
                end;
                i:=e[i].k;
        end;
end;

procedure create;
var     i,j,u,v:longint;
begin
        for i:=1 to n do head[i]:=0;
        for i:=1 to n-1 do
        begin
                readln(gi,u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
        p[1,0]:=1;h[1]:=1;
        dfs(1);
        for j:=1 to maxk do
                for i:=1 to n do
                        p[i,j]:=p[p[i,j-1],j-1];
end;

function lca(u,v:longint):longint;
var     i:longint;
begin
        if h[v]>h[u] then
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

function kc(r,u,v:longint):longint;
begin
        kc:=h[u]+h[v]-2*h[r]+1;
end;

procedure chuanhoa(k,u,v:longint);
begin
        if kc(k,u,v)<kc(res,u,v) then res:=k;
        if (kc(k,u,v)=kc(res,u,v)) and (h[k]>h[res]) then res:=k;
end;

procedure process;
var     i,u,v,k:longint;
        x:char;
begin
        readln(gi,m);
        root:=1;
        for i:=1 to m do
        begin
                read(gi,x);
                if x='!' then readln(gi,root) else
                begin
                        readln(gi,u,v);
                        res:=lca(u,v);
                        k:=lca(v,root);
                        chuanhoa(k,u,v);
                        k:=lca(u,root);
                        chuanhoa(k,u,v);
                        writeln(go,res);
                end;
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        repeat
                readln(gi,n);
                if n=0 then break;
                create;
                process;
        until false;
        close(gi);close(go);
end.
