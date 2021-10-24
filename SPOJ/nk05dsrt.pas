const   ginp='ss.inp';
        gout='ss.out';
        maxn=201;
        oo=trunc(1e17);

type    edge=record x,y,w,link:longint;end;

var     gi,go:text;
        n,m,maxc,st:longint;
        e:array[-maxn..maxn] of edge;
        d:array[0..maxn] of boolean;
        head:array[0..maxn] of longint;
        f:array[0..maxn] of qword;

function ccl(u,l:longint):int64;
var     tm:longint;
begin
        if (f[u]>maxc-l) and (maxc-2*l<=0) then exit(oo);
        tm:=f[u];ccl:=0;
        while tm>maxc-l do
        begin
                ccl:=ccl+maxc;
                tm:=tm-maxc+2*l;
        end;
        ccl:=ccl+tm+l;
end;

procedure add(i,u,v,c:longint);
begin
        with e[i] do
        begin
                x:=u;y:=v;w:=c;
                link:=head[u];
        end;
        head[u]:=i;
end;

procedure input;
var     i,u,v,c:longint;
begin
        readln(gi,n,m,maxc);
        for i:=0 to n do head[i]:=0;
        for i:=-m to m do e[i].link:=0;
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
end;

procedure dijkstra;
var     i,u,v:longint;
        tm:qword;
begin
        for i:=0 to n do f[i]:=oo;
        fillchar(d,sizeof(d),true);
        f[n]:=0;
        repeat
                u:=0;
                for i:=n downto 1 do
                        if (d[i]) and (f[i]<f[u]) then u:=i;
                d[u]:=false;
                if (u=0) or (u=1) then exit;
                i:=head[u];
                while i<>0 do
                begin
                        v:=e[i].y;
                        if d[v] then
                        begin
                                tm:=ccl(u,e[i].w);
                                if tm<f[v] then f[v]:=tm;
                        end;
                        i:=e[i].link;
                end;
        until false;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        readln(gi,st);
        while st>0 do
        begin
                input;
                dijkstra;
                writeln(go,f[1]);
                dec(st);
        end;
        close(gi);close(go);
end.
