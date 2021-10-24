const   ginp='money.inp';
        gout='money.out';
        vc=9999999999999;

var     gi,go:text;
        n,m,s,t,k:longint;
        y,w,link:array[-1001001..1001001] of longint;
        head:array[0..100100] of longint;
        d,dd,gt:array[0..100100] of int64;
        dt:array[0..100100] of boolean;

procedure ad(i,u,v,c:longint);
begin
        y[i]:=v;
        link[i]:=head[u];
        head[u]:=i;
        w[i]:=c;
end;

procedure input;
var     i,u,v,c:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        fillchar(dt,sizeof(dt),false);
        readln(gi,n,m,k);
        readln(gi,s,t);
        for i:=1 to k do
        begin
                read(gi,u,c);
                dt[u]:=true;
                gt[u]:=c;
        end;
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                ad(i,u,v,c);
                ad(-i,v,u,c);
        end;
end;

procedure dijkstra;
var     u,v,i:longint;
        put:array[0..100100] of boolean;
begin
        for i:=0 to n do d[i]:=vc;
        fillchar(put,sizeof(put),true);
        d[s]:=0;
        repeat
                u:=0;
                for i:=1 to n do
                        if (put[i]) and (d[i]<d[u]) then u:=i;
                if (u=0) then exit;
                put[u]:=false;
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if (d[v]>d[u]+w[i]) and (put[v]) then d[v]:=d[u]+w[i];
                        i:=link[i];
                end;
        until false;
end;

procedure output;
var     i:longint;
        gtm:int64;
begin
        dijkstra;
        dd:=d;
        i:=s;s:=t;t:=i;
        dijkstra;
        gtm:=vc;
        for i:=1 to n do
                if (dt[i]) and (gtm>d[i]+dd[i]+gt[i]) then gtm:=d[i]+dd[i]+gt[i];
        write(go,gtm);
        close(gi);close(go);
end;

begin
        input;
        output;
end.



