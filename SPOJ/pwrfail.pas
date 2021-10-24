const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e15);

var     gi,go:text;
        n,m:longint;
        x,y,f:array[0..1001] of real;
        d:array[0..1001,0..1001] of real;
        put:array[0..1001] of boolean;
        maxw:real;
        res:int64;

procedure input;
var     i,j,u,v:longint;
        tm:real;
begin
        readln(gi,n,m);
        readln(gi,maxw);
        for i:=1 to n do readln(gi,x[i],y[i]);
        for i:=1 to n do
                for j:=1 to n do d[i,j]:=-1;
        for i:=1 to m do
        begin
                readln(gi,u,v);
                if d[u,v]=-1 then
                begin
                        d[u,v]:=0;d[v,u]:=0;
                end;
        end;
        for i:=1 to n do
                for j:=i+1 to n do
                        if d[i,j]=-1 then
                        begin
                                tm:=sqrt(sqr(x[i]-x[j])+sqr(y[i]-y[j]));
                                if tm<=maxw then
                                begin
                                        d[i,j]:=tm;d[j,i]:=tm;
                                end;
                        end;
end;

procedure dijkstra;
var     i,u,v:longint;
begin
        for i:=0 to n do
        begin
                f[i]:=oo;
                put[i]:=true;
        end;
        f[1]:=0;
        repeat
                u:=0;
                for i:=1 to n do
                        if (put[i]) and (f[i]<f[u]) then u:=i;
                if u=0 then exit;
                put[u]:=false;
                for v:=1 to n do
                        if (d[u,v]<>-1) and (f[u]+d[u,v]<f[v]) then f[v]:=f[u]+d[u,v];
        until put[n]=false;
        res:=trunc(f[n]*1000);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        dijkstra;
        if put[n] then write(go,-1) else write(go,res);
        close(gi);close(go);
end.
