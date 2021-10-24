const   ginp='disentr.inp';
        gout='disentr.out';
        maxn=1010;
        maxm=10010;
        oo=trunc(1e9);

type    edge=record x,y,w,k,l,r:longint;end;

var     n,m,s,t,nn,start:longint;
        a,head,d:array[0..maxn] of longint;
        e:array[-maxm..maxm] of edge;
        put:array[0..maxn] of boolean;

procedure add(i,u,v,c:longint);
begin
        with e[i] do
        begin
                x:=u;y:=v;w:=c;
                k:=head[u];
        end;
        head[u]:=i;
end;

procedure dfs(ii,sum:longint);
var     i,u,v,tmp:longint;
begin
        if ii=nn then exit;
        u:=a[ii];i:=head[u];
        while i<>0 do
        begin
                v:=e[i].y;
                if v=a[ii+1] then
                begin
                        tmp:=sum+e[i].w;
                        e[i].l:=sum;e[i].r:=tmp;
                        e[-i].l:=sum;e[-i].r:=tmp;
                        dfs(ii+1,tmp);
                        exit;
                end;
                i:=e[i].k;
        end;
end;

procedure enter;
var     i,u,v,c,tt:longint;
begin
        readln(n,m);
        readln(s,t,start,nn);
        for i:=1 to nn do read(a[i]);
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
end;

procedure process;
var     i,u,v,tmp:longint;
begin
        dfs(1,0);
        for i:=0 to n do d[i]:=oo;
        fillchar(put,sizeof(put),true);
        d[s]:=start;
        repeat
                u:=0;
                for v:=1 to n do
                        if (put[v]) and (d[v]<d[u]) then u:=v;
                put[u]:=false;
                if (u=0) or (u=t) then break;
                i:=head[u];
                while i<>0 do
                begin
                        v:=e[i].y;
                        if (e[i].l<d[u]) and (d[u]<e[i].r) then tmp:=e[i].r+e[i].w
                        else tmp:=d[u]+e[i].w;
                        if tmp<d[v] then d[v]:=tmp;
                        i:=e[i].k;
                end;
        until false;
        write(d[t]-start);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
