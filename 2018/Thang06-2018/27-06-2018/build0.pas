const   ginp='build.inp';
        gout='build.out';
        oo=trunc(1e9);

type    edge=record y,k:longint;w:longint;end;

var     gi,go:text;
        n,k,m:longint;
        vk:array[1..5] of longint;
        e:array[-50010..50010] of edge;
        head:array[0..10010] of longint;

procedure add(i,u,v,c:longint);
begin
        with e[i] do
        begin
                y:=v;k:=head[u];
                w:=c;
        end;
        head[u]:=i;
end;

procedure input;
var     i,u,v,c:longint;
begin
        readln(gi,n,m,k);
        for i:=1 to k do readln(gi,vk[i]);
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
end;

procedure process;
var     i,j:longint;
        ok:boolean;
begin
        for i:=1 to k do
                for j:=i+1 to k do
                begin
                        d[i,j]:=dijkstra(
        for i:=1 to n do
        begin
                ok:=true;
                for j:=1 to k do
                        if i=vk[j] then ok:=false;
                if ok=false then continue;
                for j:=1 to k do d[0,i]:=dijkstra(i,vk[j]);

        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
