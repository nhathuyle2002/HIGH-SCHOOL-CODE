const   ginp='destroy.inp';
        gout='destroy.out';
        oo=trunc(1e16);

type    edge=record x,y,w,k:longint;end;

var     n,m,s,nh,cou,res:longint;
        e:array[-300010..300010] of edge;
        head,v,h,f:array[0..200010] of longint;
        d:array[0..200010] of int64;
        dd,put:array[0..200010] of boolean;

procedure add(i,u,v,c:longint);
begin
        with e[i] do
        begin
                x:=u;y:=v;w:=c;
                k:=head[u];
        end;
        head[u]:=i;
end;

procedure enter;
var     i,u,v,c:longint;
begin
        readln(n,m,s);
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
end;

procedure swap(i,j:longint);
var     tm:longint;
begin
        tm:=h[i];h[i]:=h[j];h[j]:=tm;
        tm:=v[h[i]];v[h[i]]:=v[h[j]];v[h[j]]:=tm;
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (d[h[j]]>d[h[j+1]]) then inc(j);
        if d[h[i]]>d[h[j]] then
        begin
                swap(i,j);
                downh(j);
        end;
end;

function pop:longint;
begin
        pop:=h[1];
        swap(1,nh);
        dec(nh);
        downh(1);
end;

procedure uph(i:longint);
var     j:longint;
begin
        j:=i shr 1;
        if j<1 then exit;
        if d[h[i]]<d[h[j]] then
        begin
                swap(i,j);
                uph(j);
        end;
end;

procedure update(i:longint);
begin
        if v[i]=0 then
        begin
                inc(nh);h[nh]:=i;
                v[i]:=nh;
        end;
        uph(v[i]);
end;

procedure dijkstra;
var     i,u,v:longint;
begin
        for i:=0 to n do
        begin
                d[i]:=oo;
                put[i]:=true;
        end;
        nh:=0;
        d[s]:=0;update(s);
        repeat
                if nh=0 then exit;
                u:=pop;i:=head[u];
                put[u]:=false;
                while i<>0 do
                begin
                        v:=e[i].y;
                        if (d[v]>d[u]+e[i].w) and (put[v]) then
                        begin
                                d[v]:=d[u]+e[i].w;
                                update(v);
                        end;
                        i:=e[i].k;
                end;
        until false;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure dfs(u:longint);
var     i,v:longint;
        ok:boolean;
begin
        dd[u]:=false;
        i:=head[u];
        f[u]:=1;
        ok:=true;
        while i<>0 do
        begin
                v:=e[i].y;
                if dd[v] then
                begin
                        if d[u]=d[v]+e[i].w then ok:=false else
                        if d[v]=d[u]+e[i].w then
                        begin
                                dfs(v);
                                f[u]:=f[u]+f[v];
                        end;
                end;
                i:=e[i].k;
        end;
        if u<>s then res:=max(res,f[u]);
        if not ok then f[u]:=0;
end;

procedure process;
var     i,u,v:longint;
begin
        fillchar(dd,sizeof(dd),true);
        res:=0;
        dfs(s);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        dijkstra;
        process;
        close(input);close(output);
end.
