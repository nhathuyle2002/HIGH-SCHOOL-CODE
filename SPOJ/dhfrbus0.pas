const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e17);
        maxn=100001;

type    edge= record x,y,link:longint;w:int64 end;
        quece= record u,k:longint; end;

var     gi,go:text;
        n,m,maxk:longint;
        e:array[-maxn..maxn] of edge;
        nh:longint;
        h:array[0..max*6] of quece;
        v:array[0..maxn,0..6] of longint;
        f:array[0..maxn,0..6] of qword;
        re:qword;
        head:array[0..10001] of longint;

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
var     i,j,u,v,c:longint;
begin
        readln(gi,n,m,maxk);
        for i:=1 to m do
        begin
                readln(gi,u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
        for i:=1 to n do
                for j:=0 to maxk do f[i,j]:=oo;
end;

procedure swap(var x,y:quece);
var     tm:quece;
        t:longint;
begin
        tm:=x;x:=y;y:=tm;
        t:=v[x.u,x.k];v[x.u,x.k]:=v[y.u,y.k];v[y.u,y.k]:=t;
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (f[h[j+1].u,h[j+1].k]<f[h[j].u,h[j].k]) then inc(j);
        if f[h[j].u,h[j].k]<f[h[i].u,h[i].k] then
        begin
                swap(h[i],h[j]);
                downh(j);
        end;
end;

function pop:quece;
begin
        pop:=h[1];
        swap(h[1],h[nh]);
        dec(nh);
        downh(1);
end;

procedure uph(i:longint);
var     j:longint;
begin
        if i<=1 then exit;
        j:=i shr 1;
        if f[h[i].u,h[i].k]<f[h[j].u,h[j].k] then
        begin
                swap(h[i],h[j]);
                uph(j);
        end;
end;

procedure push(u,k:longint);
begin
        if v[u,k]=0 then
        begin
                inc(nh);
                h[nh].u:=u;h[nh].k:=k;
                v[u,k]:=nh;
        end;
        uph(v[u,k]);
end;

procedure dijkstra;
var     i,v,k:longint;
        u:quece;
        d:array[0..10001,0..21] of boolean;
begin
        fillchar(d,sizeof(d),true);
        nh:=0;
        d[1,0]:=false;f[1,0]:=0;
        push(1,0);
        repeat
                if (nh<=0) then break;
                u:=pop;
                if u.u=n then break;
                d[u.u,u.k]:=false;
                i:=head[u.u];
                while i<>0 do
                begin
                        v:=e[i].y;
                        if (d[v,u.k]) and (f[v,u.k]>f[u.u,u.k]+e[i].w) then
                        begin
                                f[v,u.k]:=f[u.u,u.k]+e[i].w;
                                push(v,u.k);
                        end;
                        if (u.k<maxk) and (d[v,u.k+1]) and (f[v,u.k+1]>f[u.u,u.k]) then
                        begin
                                f[v,u.k+1]:=f[u.u,u.k];
                                push(v,u.k+1);
                        end;
                        i:=e[i].link;
                end;
        until false;
        re:=oo;
        for i:=0 to maxk do
                if f[n,i]<re then re:=f[n,i];
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        dijkstra;
        write(go,re);
        close(gi);close(go);
end.
