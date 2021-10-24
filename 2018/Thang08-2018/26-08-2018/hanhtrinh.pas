const   ginp='hanhtrinh.inp';
        gout='hanhtrinh.out';
        maxn=10010;
        maxk=201;
        oo=trunc(1e9)+100;

type    edge=record y,t,w,link:longint;end;
        save=record u,k:longint;end;

var     n,m,mk,st,fi,nh:longint;
        d,v:array[0..maxn,0..maxk] of longint;
        h:array[0..maxn*maxk] of save;
        e:array[-10*maxn..10*maxn] of edge;
        head:array[0..maxn] of longint;

procedure add(i,u,v,c,cc:longint);
begin
        with e[i] do
        begin
                y:=v;t:=c;w:=cc;
                link:=head[u];
        end;
        head[u]:=i;
end;

procedure enter;
var     i,u,v,c,cc:longint;
begin
        readln(mk,n,m);
        dec(mk);
        for i:=1 to m do
        begin
                readln(u,v,c,cc);
                add(i,u,v,c,cc);
                add(-i,v,u,c,cc);
        end;
        read(st,fi);
end;

function ss(i,j:longint):boolean;
begin
        if d[h[i].u,h[i].k]<d[h[j].u,h[j].k] then exit(true) else exit(false);
end;

procedure swap(i,j:longint);
var     tm:longint;
begin
        tm:=v[h[i].u,h[i].k];v[h[i].u,h[i].k]:=v[h[j].u,h[j].k];v[h[j].u,h[j].k]:=tm;
        tm:=h[i].u;h[i].u:=h[j].u;h[j].u:=tm;
        tm:=h[i].k;h[i].k:=h[j].k;h[j].k:=tm;
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (ss(j+1,j)) then inc(j);
        if ss(j,i) then
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
        if ss(i,j) then
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

procedure push(i,j:longint);
begin
        if v[i,j]=0 then
        begin
                inc(nh);
                h[nh].u:=i;h[nh].k:=j;
                v[i,j]:=nh;
        end;
        uph(v[i,j]);
end;

procedure process;
var     i,j,v:longint;
        u:save;
begin
        for i:=1 to n do
                for j:=0 to mk do d[i,j]:=oo;
        nh:=0;
        d[st,0]:=0;push(st,0);
        repeat
                u:=pop;
                if u.u=fi then
                begin
                        write(d[u.u,u.k]);
                        exit;
                end;
                i:=head[u.u];
                while i<>0 do
                begin
                        v:=e[i].y;
                        if (u.k+e[i].w<=mk) and (d[u.u,u.k]+e[i].t<d[v,u.k+e[i].w]) then
                        begin
                                d[v,u.k+e[i].w]:=d[u.u,u.k]+e[i].t;
                                push(v,u.k+e[i].w);
                        end;
                        i:=e[i].link;
                end;
        until nh=0;
        write(-1);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
