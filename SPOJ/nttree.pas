const   ginp='ss.inp';
        gout='ss.out';

type    edge=record x,y,k:longint;w:int64;d:boolean;end;

var     gi,go:text;
        n:longint;
        e:array[-10001..10001] of edge;
        head,ch:array[0..10001] of longint;
        f,g:array[0..10001] of int64;

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
        sum,tm:int64;
begin
        i:=head[u];
        sum:=0;
        while i<>0 do
        begin
                if e[i].d then
                begin
                        e[-i].d:=false;
                        v:=e[i].y;dfs(v);
                        tm:=g[v]+ch[v]*e[i].w;
                        f[u]:=f[u]+tm*ch[u]+g[u]*ch[v];
                        g[u]:=g[u]+tm;
                        ch[u]:=ch[u]+ch[v];
                        f[u]:=f[u]+f[v];
                end;
                i:=e[i].k;
        end;
        inc(ch[u]);
        f[u]:=f[u]+g[u];
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        dfs(0);
        write(go,f[0]);
        close(gi);close(go);
end.
