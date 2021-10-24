const   ginp='vexe.inp';
        gout='vexe.out';
        oo=trunc(1e9);

type    edge=record y,k,w:longint;end;
        save=record u,k:longint;end;

var     gi,go:text;
        n,m,nh:longint;
        e:array[-30010..30010] of edge;
        head:array[0..5010] of longint;
        h:array[0..10010] of save;
        f,vv:array[0..5010,0..1] of longint;

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
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i<<1;
        if j>nh then exit;
        if (j<nh) and (f[h[j+1].u,h[j+1].k]<f[h[j].u,h[j].k]) then inc(j);
        if f[h[i].u,h[i].k]>f[h[j].u,h[j].k] then
        begin
                swap(h[i].u,h[j].u);
                swap(h[i].k,h[j].k);
                swap(vv[h[i].u,h[i].k],vv[h[j].u,h[j].k]);
                downh(j);
        end;
end;

function pop:save;
begin
        pop:=h[1];
        vv[h[1].u,h[1].k]:=vv[h[nh].u,h[nh].k];
        h[1]:=h[nh];
        dec(nh);
        downh(1);
end;

procedure uph(i:longint);
var     j:longint;
begin
        j:=i>>1;
        if j<1 then exit;
        if f[h[i].u,h[i].k]<f[h[j].u,h[j].k] then
        begin
                swap(h[i].u,h[j].u);
                swap(h[i].k,h[j].k);
                swap(vv[h[i].u,h[i].k],vv[h[j].u,h[j].k]);
                uph(j);
        end;
end;

procedure push(u,k:longint);
begin
        if vv[u,k]=0 then
        begin
                inc(nh);
                vv[u,k]:=nh;
                h[nh].u:=u;
                h[nh].k:=k;
        end;
        uph(vv[u,k]);
end;

procedure dijkstra;
var     i,v:longint;
        u:save;
        put:array[0..5010,0..1] of boolean;
begin
        nh:=0;
        for i:=1 to n do
                for v:=0 to 1 do
                begin
                        f[i,v]:=oo;
                        put[i,v]:=true;
                        vv[i,v]:=0;
                end;
        f[1,0]:=0;
        push(1,0);
        repeat
                u:=pop;
                if u.u=n then break;
                put[u.u,u.k]:=false;
                i:=head[u.u];
                while i<>0 do
                begin
                        v:=e[i].y;
                        if (put[v,u.k]) and (f[v,u.k]>f[u.u,u.k]+e[i].w) then
                        begin
                                f[v,u.k]:=f[u.u,u.k]+e[i].w;
                                push(v,u.k);
                        end;
                        if u.k=0 then
                        if (put[v,1]) and (f[v,1]>f[u.u,0]) then
                        begin
                                f[v,1]:=f[u.u,0];
                                push(v,1);
                        end;
                        i:=e[i].k;
                end;
        until false;
        if f[n,0]<f[n,1] then f[n,1]:=f[n,0];
        write(go,f[n,1]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        dijkstra;
        close(gi);close(go);
end.