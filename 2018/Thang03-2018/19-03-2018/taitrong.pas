const   ginp='taitrong.inp';
        gout='taitrong.out';

var     gi,go:text;
        n,m,s,t:longint;
        d:array[0..1001] of longint;
        w:array[0..1001,0..1001] of longint;

procedure input;
var     i,u,v,c:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,s,t);
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                w[u,v]:=c;
                w[v,u]:=c;
        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure dijkstra;
var     put:array[0..1001] of boolean;
        u,v,i,tmp:longint;
begin
        fillchar(put,sizeof(put),true);
        for i:=1 to n do d[i]:=0;
        d[s]:=maxlongint;
        repeat
                u:=0;
                for i:=1 to n do
                        if (put[i]) and (d[u]<d[i]) then u:=i;
                put[u]:=false;
                if (u=0) or (u=t) then exit;
                for v:=1 to n do
                        if (w[u,v]<>0) and (put[v]) then
                        begin
                                tmp:=min(d[u],w[u,v]);
                                d[v]:=max(d[v],tmp);
                        end;
        until false;
end;

procedure output;
begin
        write(go,d[t]);
        close(gi);close(go);
end;

begin
        input;
        dijkstra;
        output;
end.
















