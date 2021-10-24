const   ginp='ss.inp';
        gout='ss.out';

type    edge=record x,y,link:longint;end;

var     gi,go:text;
        n:longint;
        f,head:array[0..401] of longint;
        e:array[0..401] of edge;

procedure sort(l,r:longint;var d:array of longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure input;
var     i,m,u,k:longint;
begin
        readln(gi,n);
        k:=0;
        repeat
                read(gi,u,m);
                if u=0 then break;
                for i:=1 to m do
                begin
                        inc(k);
                        e[k].x:=u;read(gi,e[k].y);
                        e[k].link:=head[u];
                        head[u]:=k;
                end;
                readln(gi);
        until false;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure dfs(u:longint);
var     i,v,m:longint;
        a:array[0..401] of longint;
begin
        i:=head[u];
        if i=0 then
        begin
                f[u]:=1;exit;
        end;
        m:=0;
        while i<>0 do
        begin
                v:=e[i].y;
                dfs(v);
                inc(m);a[m]:=f[v];
                i:=e[i].link;
        end;
        sort(1,m,a);
        f[u]:=m;
        for i:=1 to m do
                f[u]:=max(f[u],a[i]+m-i);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        dfs(1);
        write(go,f[1]);
        close(gi);close(go);
end.
