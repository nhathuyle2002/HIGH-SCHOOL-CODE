const   ginp='ss.inp';
        gout='ss.out';
        maxn=100001;
        vc=1e10;

type    point=record x,y:real;end;

var     gi,go:text;
        n:longint;
        a:array[0..maxn] of point;
        b,c:array[0..maxn] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,a[i].x,a[i].y);
                b[i]:=i;
        end;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:point;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i].x<t.x do inc(i);
                while a[j].x>t.x do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure meger(l,m,r:longint);
var     i,j,k,p:longint;
begin
        i:=l;j:=m+1;k:=0;
        while (i<=m) and (j<=r) do
        begin
                inc(k);
                if a[b[i]].y<=a[b[j]].y then
                begin
                        c[k]:=b[i];inc(i);
                end else
                begin
                        c[k]:=b[j];inc(j);
                end;
        end;
        if i<=m then
                for p:=i to m do
                begin
                        inc(k);c[k]:=b[p];
                end
        else    for p:=j to r do
                begin
                        inc(k);c[k]:=b[p];
                end;
        for i:=1 to k do b[i+l-1]:=c[i];
end;

function min(x,y:real):real;
begin
        if x<y then exit(x) else exit(y);
end;

function abs(x:real):real;
begin
        if x<0 then exit(-x) else exit(x);
end;

function dist(x,y:point):real;
begin
        dist:=sqrt(sqr(x.x-y.x)+sqr(x.y-y.y));
end;

function mind(l,r:longint):real;
var     m,i,j,k:longint;
        d:real;
begin
        if l>=r then exit(vc);
        m:=(l+r) div 2;
        d:=min(mind(l,m),mind(m+1,r));
        meger(l,m,r);
        j:=0;
        for i:=l to r do
                if abs(a[b[i]].x-a[m].x)<d then
                begin
                        inc(j);
                        c[j]:=b[i];
                end;
        for i:=1 to j-1 do
        begin
                k:=i+1;
                while (k<=j) and (abs(a[c[i]].y-a[c[k]].y)<d) do
                begin
                        d:=min(d,dist(a[c[i]],a[c[k]]));
                        inc(k);
                end;
        end;
        mind:=d;
end;

procedure output;
begin
        sort(1,n);
        writeln(go,mind(1,n):0:3);
        close(gi);close(go);
end;

begin
        input;
        output;
end.






