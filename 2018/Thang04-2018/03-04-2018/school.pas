const   ginp='school.inp';
        gout='school.out';

var     gi,go:text;
        n,m:longint;
        link,y,w:array[-1000100..1000100] of longint;
        head:array[0..100100] of longint;
        cd,d:array[0..100100] of int64;

procedure ad(i,u,v,c:longint);
begin
        y[i]:=v;
        w[i]:=c;
        link[i]:=head[u];
        head[u]:=i;
end;

procedure input;
var     i,k,u,v,c:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,k,u,v,c);
                ad(i,u,v,c);
                if k=2 then ad(-i,v,u,c);
        end;
end;

procedure dijkstra;
var     i,u,v:longint;
        put:array[0..100100] of boolean;
begin
        for i:=0 to n do d[i]:=maxlongint;
        fillchar(put,sizeof(put),true);
        d[1]:=0;cd[1]:=1;
        repeat
                u:=0;
                for i:=1 to n do
                        if (put[i]) and (d[i]<d[u]) then u:=i;
                if (u=0) or (u=n) then exit;
                put[u]:=false;
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if put[v] then
                        begin
                                if d[v]=d[u]+w[i] then cd[v]:=cd[v]+cd[u]
                                else if d[v]>d[u]+w[i] then
                                begin
                                        d[v]:=d[u]+w[i];
                                        cd[v]:=cd[u];
                                end;
                        end;
                        i:=link[i];
                end;
        until false;
end;

procedure output;
var     i:longint;
begin
        write(go,d[n],' ',cd[n]);
        close(gi);close(go);
end;

begin
        input;
        dijkstra;
        output;
end.











