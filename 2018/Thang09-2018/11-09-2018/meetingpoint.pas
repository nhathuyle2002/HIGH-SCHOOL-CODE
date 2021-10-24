const   ginp='meetingpoint01.inp';
        gout='meetingpoint.out';
        maxn=100010;
        maxm=200010;
        maxd=500;
        oo=trunc(1e12);

type    edge=record y,link,w:longint; end;

var     n,m,k,nheap,cou:longint;
        res:int64;
        e:array[-maxm..maxm] of edge;
        head,heap,pos:array[0..maxn] of longint;
        da,db,d:array[0..maxn] of int64;

procedure add(i,u,v,c:longint);
begin
        with e[i] do
        begin
                y:=v; w:=c;
                link:=head[u];
        end;
        head[u]:=i;
end;

procedure swapheap(i,j:longint);
var     tmp:longint;
begin
        tmp:=heap[i]; heap[i]:=heap[j]; heap[j]:=tmp;
        tmp:=pos[heap[i]]; pos[heap[i]]:=pos[heap[j]]; pos[heap[j]]:=tmp;
end;

procedure update(u:longint);
var     i,j:longint;
begin
        if pos[u]=0 then
        begin
                inc(nheap);
                heap[nheap]:=u;
                pos[u]:=nheap;
        end;
        i:=pos[u];
        while i shr 1>0 do
        begin
                j:=i shr 1;
                if d[heap[i]]>=d[heap[j]] then break;
                swapheap(i,j);
                i:=j;
        end;
end;

function pop:longint;
var     i,j:longint;
begin
        pop:=heap[1];
        swapheap(1,nheap); dec(nheap);
        i:=1;
        while i shl 1<=nheap do
        begin
                j:=i shl 1;
                if (j<nheap) and (d[heap[j+1]]<d[heap[j]]) then inc(j);
                if d[heap[i]]<=d[heap[j]] then break;
                swapheap(i,j);
                i:=j;
        end;
end;

function min(x,y:int64):int64;
begin
        if x<0 then x:=-x;
        if y<0 then y:=-y;
        if x<y then min:=x else min:=y;
end;

procedure enter;
var     i,u,v,c:longint;
begin
        readln(n,m,k);
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
end;

procedure dijkstra(start:longint);
var     i,u,v:longint;
begin
        nheap:=0;
        for u:=1 to n do
        begin
                pos[u]:=0;
                d[u]:=oo;
        end;
        d[start]:=0; update(start);
        repeat
                if nheap=0 then break;
                u:=pop; i:=head[u];
                while i<>0 do
                begin
                        v:=e[i].y;
                        if d[v]>d[u]+e[i].w then
                        begin
                                d[v]:=d[u]+e[i].w;
                                update(v);
                        end;
                        i:=e[i].link;
                end;
        until false;
        if start=1 then da:=d else db:=d;
end;

function bina_se(x:double):longint;
var     l,r,mid:longint;
begin
        l:=2;r:=cou;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if da[mid]/db[mid]<=x then l:=mid+1 else r:=mid;
        end;
        bina_se:=l;
end;

procedure sort(l,r:longint);
var     i,j,tt:longint;
        tmp:int64;
        t:double;
begin
        if l>=r then exit;
        i:=l; j:=r;
        tt:=random(r-l+1)+l; t:=da[tt]/db[tt];
        repeat
                while da[i]/db[i]<t do inc(i);
                while da[j]/db[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=da[i]; da[i]:=da[j]; da[j]:=tmp;
                        tmp:=db[i]; db[i]:=db[j]; db[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
end;

function min0(x,y:longint):longint;
begin
        if x<y then min0:=0 else min0:=y;
end;

function max0(x,y:longint):longint;
begin
        if x>y then max0:=x else max0:=y;
end;

procedure process0;
var     t,i,a,b,v:longint;
        ga,gb:int64;
begin
        ga:=da[n]; gb:=db[1];
        cou:=0;
        for i:=2 to n-1 do
                if (da[i]<oo) and (db[i]<oo) then
                begin
                        inc(cou);
                        da[cou]:=da[i]; db[cou]:=db[i];
                end;
        sort(1,cou);
        for t:=1 to k do
        begin
                readln(a,b);
                v:=bina_se(b/a);
                res:=min(ga*a,gb*b);
                for i:=max0(v-1-maxd,1) to min0(v+maxd,cou) do
                        res:=min(res,da[i]*a-db[i]*b);
                writeln(res);
        end;
end;

procedure process;
var     t,i,a,b:longint;
begin
        for t:=1 to k do
        begin
                readln(a,b);
                res:=oo;
                for i:=1 to n do
                        if (da[i]<oo) and (db[i]<oo) then
                                res:=min(res,da[i]*a-db[i]*b);
                writeln(res);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        dijkstra(1);
        dijkstra(n);
        process;
        close(input);close(output);
end.
