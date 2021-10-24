const   ginp='ss.inp';
        gout='ss.out';
        maxn=1010;

type    edge= record x,y,w,link:longint; end;

var     n,m,res,cou,ww:longint;
        a:array[0..maxn,0..maxn] of longint;
        e:array[-maxn*maxn*2..maxn*maxn*2] of edge;
        head:array[0..maxn*maxn] of longint;
        d:array[0..maxn*maxn] of boolean;

procedure sort(l,r:longint);
var     i,j,t:longint;
        tmp:edge;
begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=e[random(r-l+1)+l].w;
        repeat
                while e[i].w<t do inc(i);
                while e[j].w>t do dec(j);
                if i<=j then
                begin
                        tmp:=e[i]; e[i]:=e[j]; e[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
end;

procedure dfs(u:longint);
var     i:longint;
begin
        inc(cou); d[u]:=false;
        i:=head[u];
        while i<>0 do
        begin
                if (d[e[i].y]) and (e[i].w=ww) then dfs(e[i].y);
                i:=e[i].link;
        end;
end;

procedure enter;
var     i,j:longint;
begin
        readln(n); m:=0;
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        if i>1 then
                        begin
                                inc(m);
                                with e[m] do
                                begin
                                        x:=(i-2)*n+j; y:=(i-1)*n+j;
                                        w:=a[i,j]-a[i-1,j];
                                        if w<0 then w:=-w;
                                end;
                        end;
                        if j>1 then
                        begin
                                inc(m);
                                with e[m] do
                                begin
                                        x:=(i-1)*n+j-1; y:=(i-1)*n+j;
                                        w:=a[i,j]-a[i,j-1];
                                        if w<0 then w:=-w;
                                end;
                        end;
                end;
                readln;
        end;
end;

procedure create;
var     i:longint;
begin
        sort(1,m);
        for i:=1 to m do
        begin
                e[-i].x:=e[i].y; e[-i].y:=e[i].x; e[-i].w:=e[i].w;
                with e[i] do
                begin
                        link:=head[x]; head[x]:=i;
                end;
                with e[-i] do
                begin
                        link:=head[x]; head[x]:=-i;
                end;
        end;
        e[0].w:=e[1].w-1; e[m+1].w:=e[m].w+1;
end;

procedure process;
var     x0,y0,i,l,r:longint;
begin
        res:=1; l:=1;
        for i:=1 to n*n do d[i]:=true;
        for r:=1 to m+1 do
        if e[r].w<>e[r-1].w then
        begin
                ww:=e[r-1].w;
                for i:=l to r-1 do
                        if d[e[i].x] then
                        begin
                                cou:=0; dfs(e[i].x);
                                if res<cou then res:=cou;
                        end;
                for i:=l to r-1 do
                begin
                        d[e[i].x]:=true; d[e[i].y]:=true;
                end;
                l:=r;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        create;
        process;
        close(input);close(output);
end.
