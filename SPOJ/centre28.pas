const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e9);

type    egde=record x,y,w,link:longint;end;

var     gi,go:text;
        n,m,nh,res:longint;
        e:array[-100000..100000] of egde;
        head,h,f1,f2,v,f,d1,d2,d:array[0..30001] of longint;

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
        j:=i shl 1;
        if j>nh then exit;
        if (j<nh) and (f[h[j+1]]<f[h[j]]) then inc(j);
        if f[h[j]]<f[h[i]] then
        begin
                swap(h[i],h[j]);
                swap(v[h[i]],v[h[j]]);
                downh(j);
        end;
end;

function pop:longint;
begin
        pop:=h[1];
        swap(h[1],h[nh]);
        swap(v[h[1]],v[h[nh]]);
        dec(nh);
        downh(1);
end;

procedure uph(i:longint);
var     j:longint;
begin
        if i<=1 then exit;
        j:=i shr 1;
        if f[h[i]]<f[h[j]] then
        begin
                swap(h[i],h[j]);
                swap(v[h[i]],v[h[j]]);
                uph(j);
        end;
end;

procedure push(i:longint);
begin
        if v[i]=0 then
        begin
                inc(nh);
                h[nh]:=i;
                v[i]:=nh;
        end;
        uph(v[i]);
end;

procedure dijkstra(s,t:longint);
var     i,u,uu:longint;
        put:array[0..30001] of boolean;
begin
        fillchar(put,sizeof(put),true);
        fillchar(d,sizeof(d),0);
        fillchar(v,sizeof(v),0);
        for i:=1 to n do f[i]:=oo;
        nh:=0;put[s]:=false;f[s]:=0;push(s);d[s]:=1;
        repeat
                if nh<=0 then exit;
                u:=pop;
                if (u=t) then exit;
                put[u]:=false;
                i:=head[u];
                while i<>0 do
                begin
                        uu:=e[i].y;
                        if (put[uu]) and (f[uu]>f[u]+e[i].w) then
                        begin
                                f[uu]:=f[u]+e[i].w;
                                d[uu]:=d[u];
                                push(uu);
                        end else
                        if (put[uu]) and (f[uu]=f[u]+e[i].w) then
                                d[uu]:=d[u]+d[uu];
                        i:=e[i].link;
                end;
        until false;
end;

{function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        inc(cou);num[u]:=cou;
        low[u]:=oo;
        i:=head[u];
        while i<>0 do
        begin
                v:=e[i].y;
                if (d[v]) and (dd[i]) then
                begin
                        dd[-i]:=false;
                        if pa[v]=0 then
                        begin
                                pa[v]:=u;dfs(v);
                                low[u]:=min(low[u],low[v]);
                        end else
                                low[u]:=min(low[u],num[v]);
                end;
                i:=e[i].link;
        end;
end;}

procedure process;
var     i:longint;
begin
        dijkstra(1,n);f1:=f;d1:=d;
        dijkstra(n,1);f2:=f;d2:=d;
        res:=0;
        for i:=1 to n do
                if (f1[i]+f2[i]<>f1[n]) or (d1[i]*d2[i]<>d1[n]) then inc(res);
        writeln(go,res);
        for i:=1 to n do
                if (f1[i]+f2[i]<>f1[n]) or (d1[i]*d2[i]<>d1[n]) then writeln(go,i);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
