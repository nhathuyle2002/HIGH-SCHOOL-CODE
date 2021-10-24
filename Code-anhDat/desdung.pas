const   ginp='destroy.inp';
        gout='destroy.out';
        oo=trunc(1e16);

type    edge=record x,y,w,k:longint;end;

var     n,m,s,nh,top,res,cou:longint;
        e:array[-300010..300010] of edge;
        head,v,h,deg,dgoc,st:array[0..200010] of longint;
        d:array[0..200010] of int64;
        dd,dst:array[0..200010] of boolean;

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
        for i:=0 to n do d[i]:=oo;
        nh:=0;
        d[s]:=0;update(s);
        repeat
                if nh=0 then exit;
                u:=pop;i:=head[u];
                while i<>0 do
                begin
                        v:=e[i].y;
                        if d[v]>d[u]+e[i].w then
                        begin
                                d[v]:=d[u]+e[i].w;
                                deg[v]:=1;
                                update(v);
                        end else
                        if d[v]=d[u]+e[i].w then inc(deg[v]);
                        i:=e[i].k;
                end;
        until false;
end;

procedure sort(l,r:longint);
var     i,j,tm:longint;
        t:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[v[random(r-l+1)+l]];
        repeat
                while d[v[i]]<t do inc(i);
                while d[v[j]]>t do dec(j);
                if i<=j then
                begin
                        tm:=v[i];v[i]:=v[j];v[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        dd[u]:=false;
        i:=head[u];
        while i<>0 do
        begin
                v:=e[i].y;
                if d[v]=d[u]+e[i].w then
                begin
                        deg[v]:=deg[v]-1;
                        if dst[v] then
                        begin
                                dst[v]:=false;
                                inc(top);st[top]:=v;
                        end;
                        if deg[v]=0 then
                        begin
                                inc(cou);
                                dfs(v);
                        end;
                end;
                i:=e[i].k;
        end;
end;

procedure process;
var     i,ii:longint;
begin
        for i:=1 to n do v[i]:=i;
        sort(1,n);
        dgoc:=deg;
        res:=0;
        fillchar(dd,sizeof(dd),true);
        fillchar(dst,sizeof(dst),true);
        for i:=2 to n do
                if (dd[v[i]]) and (deg[v[i]]>0) then
                begin
                        top:=0;cou:=1;
                        dfs(v[i]);
                        for ii:=1 to top do deg[st[ii]]:=dgoc[st[ii]];
                        if cou>res then res:=cou;
                end;
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
