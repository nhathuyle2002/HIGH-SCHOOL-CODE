const   ginp='ss.inp';
        gout='ss.out';
        kk=round(1e9)+7;

type    edge=record x,y,k,w:longint;d:boolean;end;

var     gi,go:text;
        n:longint;
        e:array[-100001..100001] of edge;
        head:array[0..100001] of longint;
        f,g:array[0..100001] of int64;

procedure add(i,u,v,c:longint);
begin
        with e[i] do
        begin
                x:=u;y:=v;w:=c;
                k:=head[u];
                d:=true;
        end;
        head[u]:=i;
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

procedure dfs(u:longint);
var     i,v:longint;
        tm:int64;
begin
        i:=head[u];
        while i<>0 do
        begin
                if e[i].d then
                begin
                        e[-i].d:=false;
                        v:=e[i].y;dfs(v);
                        tm:=(g[v]*e[i].w+e[i].w) mod kk;
                        f[u]:=(f[u]+g[u]*tm) mod kk;
                        g[u]:=(g[u]+tm) mod kk;
                        f[u]:=(f[u]+f[v]) mod kk;
                end;
                i:=e[i].k;
        end;
        f[u]:=(f[u]+g[u]) mod kk;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        dfs(1);
        write(go,f[1]);
        close(gi);close(go);
end.
