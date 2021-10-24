const   ginp='destroy.inp';
        gout='destroy.out';
        oo=trunc(1e16);

type    edge=record x,y,w,k:longint;dd:boolean;end;

var     n,m,s,nh,cou,res:longint;
        e:array[-300010..300010] of edge;
        head,v,h,num,low,ch,f,pa:array[0..200010] of longint;
        d:array[0..200010] of int64;
        dd,put:array[0..200010] of boolean;

procedure add(i,u,v,c:longint);
begin
        with e[i] do
        begin
                x:=u;y:=v;w:=c;
                k:=head[u];
                dd:=false;
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

procedure tslc(u:longint);
var     i,v:longint;
begin
        f[u]:=1;
        i:=head[u];
        while i<>0 do
        begin
                if e[i].dd then
                begin
                        v:=e[i].y;
                        tslc(v);
                        f[u]:=f[u]+f[v];
                end;
                i:=e[i].k;
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        inc(cou);
        num[u]:=cou;
        low[u]:=n+1;
        f[u]:=1;
        i:=head[u];
        while i<>0 do
        begin
                if e[i].dd then
                begin
                        e[-i].dd:=false;
                        v:=e[i].y;
                        if num[v]=0 then
                        begin
                                pa[v]:=u;
                                dfs(v);
                                low[u]:=min(low[u],low[v]);
                                f[u]:=f[u]+f[v];
                        end
                        else    low[u]:=min(low[u],num[v]);
                end;
                i:=e[i].k;
        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,u,v:longint;
begin
        for i:=-m to m do
                if d[e[i].y]=d[e[i].x]+e[i].w then e[i].dd:=true;
        tslc(s);
        for i:=-m to m do
                if e[i].dd then e[-i].dd:=true;
        cou:=0;dfs(s);
        fillchar(dd,sizeof(dd),false);
        for i:=1 to n do
                if pa[i]>0 then inc(ch[pa[i]]);
        for v:=1 to n do
                if pa[v]>0 then
                begin
                        u:=pa[v];
                        if (pa[u]>0) or (ch[u]>1) then dd[u]:=true;
                end;
        if ch[s]>0 then res:=1 else res:=0;
        for i:=1 to n do
                if (i<>s) and (dd[i]) then res:=max(res,f[i]);
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
close

