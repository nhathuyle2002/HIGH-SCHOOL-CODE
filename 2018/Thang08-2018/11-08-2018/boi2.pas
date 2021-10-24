const   ginp='boi2.inp';
        gout='boi2.out';
        maxm=200010;
        maxn=100010;

type    edge=record x,y,w,k:longint;end;

var     n,m,mm:longint;
        e1:array[0..maxm] of edge;
        e2:array[-maxn..maxn] of edge;
        pa,ch,head:array[0..maxn] of longint;
        d:array[0..2*maxm] of int64;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:edge;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=e1[random(r-l+1)+l];
        repeat
                while e1[i].w<t.w do inc(i);
                while e1[j].w>t.w do dec(j);
                if i<=j then
                begin
                        tm:=e1[i];e1[i]:=e1[j];e1[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i,u,v,c:longint;
begin
        readln(n,m);
        for i:=1 to m do readln(e1[i].x,e1[i].y,e1[i].w);
end;

procedure add(i,u,v,c:longint);
begin
        with e2[i] do
        begin
                x:=u;y:=v;w:=c;
                k:=head[u];
        end;
        head[u]:=i;
end;

function root(p:longint):longint;
begin
        while pa[p]<>p do p:=pa[p];
        root:=p;
end;

procedure kruscal;
var     i,x0,y0:longint;
begin
        sort(1,m);
        mm:=0;
        for i:=1 to n do pa[i]:=i;
        for i:=1 to m do
        begin
                x0:=root(e1[i].x);y0:=root(e1[i].y);
                if x0<>y0 then
                begin
                        inc(mm);
                        add(mm,e1[i].x,e1[i].y,e1[i].w);
                        add(-mm,e1[i].y,e1[i].x,e1[i].w);
                        pa[y0]:=x0;pa[e1[i].x]:=x0;pa[e1[i].y]:=x0;
                end;
                if mm=n-1 then break;
        end;
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        i:=head[u];
        ch[u]:=1;
        while i<>0 do
        begin
                v:=e2[i].y;
                if pa[v]=0 then
                begin
                        pa[v]:=i;
                        dfs(v);
                        ch[u]:=ch[u]+ch[v];
                end;
                i:=e2[i].k;
        end;
end;

procedure process;
var     i,ii,mem:longint;
begin
        for i:=1 to n do pa[i]:=0;
        pa[1]:=maxn+1;dfs(1);
        for i:=2 to n do
        begin
                ii:=e2[pa[i]].w;
                d[ii]:=d[ii]+int64(ch[i])*(ch[1]-ch[i]);
        end;
        mem:=0;
        for i:=0 to 2*m do
        begin
                d[i]:=d[i]+mem;
                if d[i]>1 then
                begin
                        mem:=d[i] shr 1;
                        d[i]:=d[i] and 1;
                end else mem:=0;
        end;
        for ii:=2*m downto 0 do
                if d[ii]=1 then break;
        for i:=ii downto 0 do write(d[i]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        kruscal;
        process;
        close(input);close(output);
end.
