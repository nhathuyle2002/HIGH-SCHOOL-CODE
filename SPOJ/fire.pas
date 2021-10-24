const   ginp='ss.inp';
        gout='ss.out';
        p=100;

type    circle=record x,y,r,d:double;end;

var     gi,go:text;
        n:longint;
        ans:double;
        a:array[0..10010] of circle;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i].x,a[i].y,a[i].r);
end;

function dist(x,y:circle):double;
begin
        dist:=sqrt(sqr(x.x-y.x)+sqr(x.y-y.y));
        dist:=dist-x.r-y.r;
end;

procedure swap(var x,y:circle);
var      tm:circle;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort1(l,r:longint);
var     i,j:longint;
        t:circle;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].x<t.x) or ((a[i].x=t.x) and (a[i].y<t.y)) do inc(i);
                while (a[j].x>t.x) or ((a[j].x=t.x) and (a[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort1(l,j);sort1(i,r);
end;

procedure sort2(l,r:longint);
var     i,j:longint;
        t:circle;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].y<t.y) or ((a[i].y=t.y) and (a[i].x<t.x)) do inc(i);
                while (a[j].y>t.y) or ((a[j].y=t.y) and (a[j].x>t.x)) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort2(l,j);sort2(i,r);
end;

procedure sort3(l,r:longint);
var     i,j:longint;
        t:circle;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].x+a[i].y)<(t.x+t.y) do inc(i);
                while (a[j].x+a[j].y)>(t.x+t.y) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort3(l,j);sort3(i,r);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:double):double;
begin
        if x<y then exit(x) else exit(y);
end;

procedure check;
var     i,j:longint;
begin
        for i:=1 to n do
                for j:=i-1 downto max(1,i-p) do
                        ans:=min(ans,dist(a[i],a[j]));
end;

procedure output;
var     i:longint;
begin
        ans:=1e15;
        sort1(1,n);check;
        sort2(1,n);check;
        sort3(1,n);check;
        writeln(int64(trunc(ans*10000))/10000:0:4);
        close(gi);close(go);
end;

begin
        input;
        output;
end.
