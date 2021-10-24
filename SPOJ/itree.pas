const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e9);

type    edge=record x,y,w,link:longint;end;

var     gi,go:text;
        n,st:longint;
        e:array[0..1001] of edge;
        f:array[0..1001,0..1] of longint;
        head:array[0..1001] of longint;
        //d:array[0..1001] of boolean;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                e[i].link:=0;head[i]:=0;
        end;
        for i:=2 to n do
        begin
                readln(gi,e[i].x,e[i].w);
                e[i].y:=i;
                e[i].link:=head[e[i].x];
                head[e[i].x]:=i;
        end;
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        //if d[u]=false then exit;
        //d[u]:=false;
        i:=head[u];
        if i=0 then
        begin
                f[u,0]:=0;f[u,1]:=oo;
                exit;
        end;
        f[u,0]:=0;f[u,1]:=0;
        while i<>0 do
        begin
                v:=e[i].y;
                dfs(v);
                f[u,0]:=f[u,0]+f[v,0];
                f[u,1]:=f[u,1]+min(f[v,1],f[v,0]+e[i].w);
                i:=e[i].link;
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        readln(gi,st);
        while st>0 do
        begin
                input;
                dfs(1);
                writeln(go,f[1,1],'.00');
                dec(st);
        end;
        close(gi);close(go);
end.
