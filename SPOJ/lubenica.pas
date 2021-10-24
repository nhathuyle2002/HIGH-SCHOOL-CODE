const   ginp='ss.inp';
        gout='ss.out';
        maxn=100005;
        maxk=18;
        oo=trunc(1e8);

type    edge=record y,w,k:longint;d:boolean;end;

var     gi,go:text;
        n,q,resmi,resma:longint;
        head,h:array[0..maxn] of longint;
        e:array[-maxn..maxn] of edge;
        p,ma,mi:array[0..maxn,0..maxk] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure add(i,u,v,c:longint);
begin
        with e[i] do
        begin
                y:=v;w:=c;
                k:=head[u];d:=true;
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
                        ma[v,0]:=e[i].w;
                        mi[v,0]:=e[i].w;
                        h[v]:=h[u]+1;
                        dfs(v);
                end;
                i:=e[i].k;
        end;
end;

procedure lca(u,v:longint);
var     i,j:longint;
begin
        resmi:=oo;resma:=0;
        for i:=maxk downto 0 do
                if h[p[u,i]]>=h[v] then
                begin
                        resma:=max(resma,ma[u,i]);
                        resmi:=min(resmi,mi[u,i]);
                        u:=p[u,i];
                end;
        if u=v then exit;
        for i:=maxk downto 0 do
                if p[u,i]<>p[v,i] then
                begin
                        resma:=max(resma,max(ma[u,i],ma[v,i]));
                        resmi:=min(resmi,min(mi[u,i],mi[v,i]));
                        u:=p[u,i];v:=p[v,i];
                end;
        resma:=max(resma,max(ma[u,0],ma[v,0]));
        resmi:=min(resmi,min(mi[u,0],mi[v,0]));
end;

procedure input;
var     i,u,v,c:longint;
begin
        readln(gi,n);
        for i:=1 to n-1 do
        begin
                readln(gi,u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
end;

procedure process;
var     i,j,u,v:longint;
begin
        h[1]:=1;dfs(1);
        p[1,0]:=1;ma[1,0]:=0;mi[1,0]:=oo;
        for j:=1 to maxk do
                for i:=1 to n do
                begin
                        p[i,j]:=p[p[i,j-1],j-1];
                        ma[i,j]:=max(ma[i,j-1],ma[p[i,j-1],j-1]);
                        mi[i,j]:=min(mi[i,j-1],mi[p[i,j-1],j-1]);
                end;
        readln(gi,q);
        for i:=1 to q do
        begin
                readln(gi,u,v);
                if u=v then writeln(go,0,' ',0) else
                if h[u]<h[v] then lca(v,u) else lca(u,v);
                writeln(go,resmi,' ',resma);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
