const   ginp='';
        gout='';
        maxn=100001;
        oo=trunc(1e17);

type    edge=record x,y,link:longint; w:int64;end;
        save=record u,p:longint;end;

var     gi,go:text;
        n,m,k,s,t:longint;
        e:array[-maxn..maxn] of edge;
        head:array[0..maxn] of longint;
        nh:longint;
        h:array[0..maxn*6] of save;
        f:array[0..maxn,0..6] of int64;
        v:array[0..maxn,0..6] of longint;
        d:array[0..maxn,0..6] of boolean;
        res:int64;

procedure add(i,u,v:longint;c:int64);
begin
        with e[i] do
        begin
                x:=u;y:=v;w:=c;
                link:=head[u];
        end;
        head[u]:=i;
end;

function gt(i:longint):int64;
begin
        gt:=f[h[i].u,h[i].p];
end;

procedure swap(i,j:longint);
var     tm1:longint;
        tm2:save;
begin
        tm1:=v[h[i].u,h[i].p];v[h[i].u,h[i].p]:=v[h[j].u,h[j].p];v[h[j].u,h[j].p]:=tm1;
        tm2:=h[i];h[i]:=h[j];h[j]:=tm2;
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (gt(j)>gt(j+1)) then inc(j);
        if gt(i)>gt(j) then
        begin
                swap(i,j);
                downh(j);
        end;
end;

procedure uph(i:longint);
var     j:longint;
begin
        j:=i shr 1;
        if j<1 then exit;
        if gt(i)<gt(j) then
        begin
                swap(i,j);
                uph(j);
        end;
end;

function pop:save;
begin
        pop:=h[1];
        swap(1,nh);
        dec(nh);
        downh(1);
end;

procedure push(u,p:longint);
begin
        if v[u,p]=0 then
        begin
                inc(nh);
                h[nh].u:=u;
                h[nh].p:=p;
                v[u,p]:=nh;
        end;
        uph(v[u,p]);
end;

procedure input;
var     i,u,v:longint;
		c:int64;
begin
        readln(gi,n,m,k,s,t);
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
end;

procedure dijkstra;
var     i,j,p,vv:longint;
        u:save;
begin
        for i:=1 to n do
                for j:=0 to k do f[i,j]:=oo;
        fillchar(d,sizeof(d),true);
        f[s,0]:=0;push(s,0);
        repeat
                if nh<=0 then exit;
                u:=pop;
                if u.u=t then
                begin
                        res:=f[u.u,u.p];
                        exit;
                end;
                d[u.u,u.p]:=false;
                i:=head[u.u];
                while i<>0 do
                begin
                        vv:=e[i].y;
                        if (f[u.u,u.p]+e[i].w<f[vv,u.p]) and (d[vv,u.p]) then
                        begin
                                f[vv,u.p]:=f[u.u,u.p]+e[i].w;
                                push(vv,u.p);
                        end;
                        if (f[u.u,u.p]<f[vv,u.p+1]) and (u.p<k) and (d[vv,u.p+1]) then
                        begin
                                f[vv,u.p+1]:=f[u.u,u.p];
                                push(vv,u.p+1);
                        end;
                        i:=e[i].link;
                end;
        until false;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        dijkstra;
        write(go,res);
        close(gi);close(go);
end.

