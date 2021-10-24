const   ginp='ss.inp';
        gout='ss.out';

type    edge=record y,w,k:longint;end;

var     gi,go:text;
        n,m,cou:longint;
        e:array[-100010..100010] of edge;
        head,d:array[0..100010] of longint;

procedure add(i,u,v,c:longint);
begin
        with e[i] do
        begin
                y:=v;w:=c;
                k:=head[u];
        end;
        head[u]:=i;
end;

procedure input;
var     i,v,c:longint;
begin
        readln(gi,n,m);
        for i:=2 to n do
        begin
                readln(gi,v,c);
                add(i,i,v,c);
                add(-i,v,i,c);
        end;
end;

procedure dfs(u:longint);
var     v,i:longint;
begin
        d[u]:=cou;
        i:=head[u];
        while i<>0 do
        begin
                v:=e[i].y;
                if (d[v]=0) and (e[i].w<>2) then dfs(v);
                i:=e[i].k;
        end;
end;

procedure process;
var     i,u,v:longint;
begin
        cou:=0;
        for i:=1 to n do
                if d[i]=0 then
                begin
                        inc(cou);
                        dfs(i);
                end;
        for i:=1 to m do
        begin
                readln(gi,u,v);
                if d[u]=d[v] then writeln(go,'NO') else writeln(go,'YES');
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
