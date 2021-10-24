const   ginp='ss.inp';
        gout='ss.out';
        maxn=100010;

type    edge=record y,k:longint;end;
        mang=record c,l,r:longint;end;

var     gi,go:text;
        n,cou:longint;
        res:int64;
        e:array[0..maxn] of edge;
        a:array[0..maxn] of mang;
        head:array[0..maxn] of longint;
        b:array[0..2*maxn] of longint;

procedure input;
var     i,u:longint;
begin
        readln(gi,n);
        readln(gi,a[1].c);
        for i:=2 to n do
        begin
                readln(gi,u,a[i].c);
                e[i].y:=i;
                e[i].k:=head[u];
                head[u]:=i;
        end;
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        inc(cou);
        a[u].l:=cou;
        i:=head[u];
        while i<>0 do
        begin
                v:=e[i].y;
                dfs(v);
                i:=e[i].k;
        end;
        inc(cou);
        a[u].r:=cou;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:mang;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].c<t.c) or ((a[i].c=t.c) and (a[i].l<t.l)) do inc(i);
                while (a[j].c>t.c) or ((a[j].c=t.c) and (a[j].l>t.l)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function qu(i:longint):longint;
begin
        if i=0 then exit(0);
        qu:=b[i]+qu(i-i and (-i));
end;

procedure up(i:longint);
begin
        if i>2*n then exit;
        inc(b[i]);
        up(i+i and (-i));
end;

procedure process;
var     i,tm:longint;
begin
        cou:=0;dfs(1);
        sort(1,n);
        res:=0;
        for i:=1 to n do
        begin
                tm:=qu(a[i].r)-qu(a[i].l);
                res:=res+tm*(tm-1) shr 1;
                up(a[i].r);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
