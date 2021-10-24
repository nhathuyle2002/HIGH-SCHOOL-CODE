const   ginp='convexhull.inp';
        gout='convexhull.out';
        maxn=100010;
        oo=trunc(1e9)+10;

type    point=record x,y:int64;end;

var     gi,go:text;
        np,nq,ra,rb:longint;
        a,b,p,q:array[0..maxn] of point;

procedure swap(var xx,yy:point);
var     tm:point;
begin
        tm:=xx;xx:=yy;yy:=tm;
end;

function area(x,y,z:point):int64;
var     s:int64;
begin
        s:=(y.x-x.x)*(y.y+x.y);
        s:=s+(z.x-y.x)*(z.y+y.y);
        s:=s+(x.x-z.x)*(x.y+z.y);
        area:=s;
        {dien tich chia 2}
end;

procedure sort1(l,r:longint);
var     i,j:longint;
        t:point;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=p[random(r-l+1)+l];
        repeat
                while (p[i].x<t.x) or ((p[i].x=t.x) and (p[i].y<t.y)) do inc(i);
                while (p[j].x>t.x) or ((p[j].x=t.x) and (p[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        swap(p[i],p[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort1(l,j);sort1(i,r);
end;

procedure sort2(l,r:longint);
var     i,j:longint;
        t:point;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=q[random(r-l+1)+l];
        repeat
                while (q[i].x<t.x) or ((q[i].x=t.x) and (q[i].y<t.y)) do inc(i);
                while (q[j].x>t.x) or ((q[j].y=t.y) and (q[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        swap(q[i],q[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort2(l,j);sort2(i,r);
end;

procedure input;
var     i,n:longint;
        d1,d2:point;
        tm:int64;
        d:array[0..maxn] of point;
begin
        readln(gi,n);
        d1.x:=oo;d2.x:=-oo;
        for i:=1 to n do
        begin
                read(gi,d[i].x,d[i].y);
                if (d[i].x<d1.x) or ((d[i].x=d1.x) and (d[i].y<d1.y)) then d1:=d[i];
                if (d[i].x>d2.x) or ((d[i].x=d2.x) and (d[i].y>d1.y)) then d2:=d[i];
        end;
        np:=0;nq:=0;
        for i:=1 to n do
        begin
                tm:=area(d1,d[i],d2);
                if tm>=0 then
                begin
                        inc(np);p[np]:=d[i];
                end;
                if tm<=0 then
                begin
                        inc(nq);q[nq]:=d[i];
                end;
        end;
        sort1(1,np);sort2(1,nq);
end;

procedure process;
var     i,v:longint;
        s:int64;
begin
        a[1]:=p[1];a[2]:=p[2];ra:=2;
        for i:=3 to np do
        begin
                while (ra>=2) and (area(a[ra-1],a[ra],p[i])<=0) do dec(ra);
                inc(ra);a[ra]:=p[i];
        end;
        b[1]:=q[1];b[2]:=q[2];rb:=2;
        for i:=2 to nq do
        begin
                while (rb>=2) and (area(b[rb-1],b[rb],q[i])>=0) do dec(rb);
                inc(rb);b[rb]:=q[i];
        end;
        for i:=rb-1 downto 2 do
        begin
                inc(ra);a[ra]:=b[i];
        end;
        a[ra+1]:=a[1];
        s:=0;
        for i:=1 to ra do
                s:=s+(a[i+1].x-a[i].x)*(a[i+1].y+a[i].y);
        writeln(go,ra);
        writeln(go,s/2:0:1);
        v:=1;
        for i:=2 to ra do
                if (a[i].y<a[v].y) or ((a[i].y=a[v].y) and (a[i].x<a[v].x)) then v:=i;
        for i:=v downto 1 do writeln(go,a[i].x,' ',a[i].y);
        for i:=ra downto v+1 do writeln(go,a[i].x,' ',a[i].y);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.





