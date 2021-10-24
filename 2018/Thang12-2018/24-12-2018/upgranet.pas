const   ginp='upgranet.inp';
        gout='upgranet.out';
        maxn=100010;
        maxlog=19;

type    edge=record x,y,w,k:longint; end;

var     n,m,mlog:longint;
        res:int64;
        e:array[0..maxn] of edge;
        e0:array[-maxn..maxn] of edge;
        root,head,h:array[0..maxn] of longint;
        pa,f:array[0..maxn,0..maxlog] of longint;

procedure sort(l,r:longint);
var     i,j,t:longint;
        tm:edge;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=e[random(r-l+1)+l].w;
        repeat
                while e[i].w<t do inc(i);
                while e[j].w>t do dec(j);
                if i<=j then
                begin
                        tm:=e[i];e[i]:=e[j];e[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function f_root(p:longint):longint;
begin
        while p<>root[p] do p:=root[p];
        f_root:=p;
end;

procedure add(i,u,v,c:longint);
begin
        with e0[i] do
        begin
                x:=u; y:=v; w:=c;
                k:=head[u];
        end;
        head[u]:=i;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        i:=head[u];
        while i<>0 do
        begin
                v:=e0[i].y;
                if h[v]=0 then
                begin
                        pa[v,0]:=u;
                        f[v,0]:=e0[i].w;
                        h[v]:=h[u]+1;
                        dfs(v);
                end;
                i:=e0[i].k;
        end;
end;

function lca(u,v:longint):longint;
var     k:longint;
begin
        lca:=maxlongint;
        for k:=mlog downto 0 do
                if h[pa[u,k]]>=h[v] then
                begin
                        lca:=min(lca,f[u,k]);
                        u:=pa[u,k];
                end;
        if u=v then exit(lca);
        for k:=mlog downto 0 do
                if pa[u,k]<>pa[v,k] then
                begin
                        lca:=min(lca,min(f[u,k],f[v,k]));
                        u:=pa[u,k]; v:=pa[v,k];
                end;
        lca:=min(lca,min(f[u,0],f[v,0]));
end;

procedure enter;
var     i:longint;
begin
        readln(n,m);
        for i:=1 to m do readln(e[i].x,e[i].y,e[i].w);
        mlog:=trunc(ln(n)/ln(2))+1;
end;

procedure kruscal;
var     i,u,v,cou:longint;
begin
        sort(1,m);
        for u:=1 to n do root[u]:=u;
        cou:=0;
        for i:=m downto 1 do
        begin
                if cou=n-1 then break;
                u:=f_root(e[i].x);
                v:=f_root(e[i].y);
                if u<>v then
                begin
                        root[e[i].x]:=u;
                        root[v]:=u;
                        root[e[i].y]:=u;
                        inc(cou);
                        add(cou,e[i].x,e[i].y,e[i].w);
                        add(-cou,e[i].y,e[i].x,e[i].w);
                end;
        end;
end;

procedure create;
var     i,k:longint;
begin
        h[1]:=1; dfs(1);
        for k:=1 to mlog do
                for i:=1 to n do
                begin
                        pa[i,k]:=pa[pa[i,k-1],k-1];
                        f[i,k]:=min(f[i,k-1],f[pa[i,k-1],k-1]);
                end;
end;

procedure process;
var     i,tmp:longint;
begin
        res:=0;
        for i:=1 to m do
        begin
                if h[e[i].x]>h[e[i].y] then tmp:=lca(e[i].x,e[i].y) else tmp:=lca(e[i].y,e[i].x);
                res:=res+tmp-e[i].w;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        kruscal;
        create;
        process;
        close(input);close(output);
end.
