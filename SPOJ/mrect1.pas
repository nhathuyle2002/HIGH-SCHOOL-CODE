const   ginp='ss.inp';
        gout='ss.out';
        maxn=400010;

type    point=record x,y:longint;end;

var     n,m,cou:longint;
        d,v,f:array[0..2*maxn] of longint;
        res:array[0..maxn] of longint;
        a,b,p:array[0..maxn] of point;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sorty(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        swap(d[i],d[j]);
                        swap(v[i],v[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sorty(l,j);sorty(i,r);
end;

procedure sortx(l,r:longint; var c:array of point);
var     i,j:longint;
        tm,t:point;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=c[random(r-l+1)+l];
        repeat
                while (c[i].x<t.x) or ((c[i].x=t.x) and (c[i].y<t.y)) do inc(i);
                while (c[j].x>t.x) or ((c[j].x=t.x) and (c[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        tm:=c[i];c[i]:=c[j];c[j]:=tm;
                        swap(v[i],v[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sortx(l,j,c);sortx(i,r,c);
end;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                readln(a[i].x,a[i].y);
                v[i]:=i;d[i]:=a[i].y;
        end;
        readln(m);
        for i:=1 to m do
        begin
                readln(b[4*i-3].x,b[4*i-3].y,b[4*i].x,b[4*i].y);
                dec(b[4*i-3].x);dec(b[4*i-3].y);
                b[4*i-2].x:=b[4*i-3].x;b[4*i-2].y:=b[4*i].y;
                b[4*i-1].x:=b[4*i].x;b[4*i-1].y:=b[4*i-3].y;
                v[n+4*i-3]:=n+4*i-3;d[n+4*i-3]:=b[4*i-3].y;
                v[n+4*i-2]:=n+4*i-2;d[n+4*i-2]:=b[4*i-2].y;
                v[n+4*i-1]:=n+4*i-1;d[n+4*i-1]:=b[4*i-1].y;
                v[n+4*i]:=n+4*i;d[n+4*i]:=b[4*i].y;
        end;
        p:=b;
        sorty(1,n+4*m);
        cou:=0;
        for i:=1 to n+4*m do
        begin
                if d[i]>d[i-1] then inc(cou);
                if v[i]<=n then a[v[i]].y:=cou
                else b[v[i]-n].y:=cou;
        end;
        sortx(1,n,a);
        for i:=1 to 4*m do v[i]:=i;
        sortx(1,4*m,b);
end;

procedure update(i,x:longint);
begin
        if i>cou then exit;
        f[i]:=f[i]+x;
        update(i+i and (-i),x);
end;

function quece(i:longint):longint;
begin
        if i<1 then exit(0);
        quece:=f[i]+quece(i-i and (-i));
end;

procedure process;
var     i,j,tmp:longint;
begin
        j:=1;
        for i:=1 to 4*m do
        begin
                while (j<=n) and (a[j].x<=b[i].x) do
                begin
                        update(a[j].y,1);
                        inc(j);
                end;
                tmp:=quece(b[i].y);
                if (v[i] and 3=0) or (v[i] and 3=1) then inc(res[(v[i]-1) div 4+1],tmp) else dec(res[(v[i]-1) div 4+1],tmp);
        end;
end;

procedure result;
var     i,j:longint;
begin
        for i:=1 to m do
        begin
                inc(p[4*i-3].x);inc(p[4*i-3].y);
                p[4*i-2].x:=p[4*i-3].x;p[4*i-2].y:=p[4*i].y;
                p[4*i-1].x:=p[4*i].x;p[4*i-1].y:=p[4*i-3].y;
                v[4*i-3]:=4*i-3;v[4*i-2]:=4*i-2;
                v[4*i-1]:=4*i-1;v[4*i]:=4*i;
        end;
        sortx(1,4*m,p);
        j:=1;
        for i:=1 to 4*m do
        begin
                while (j<=n) and ((a[j].x<p[i].x) or ((a[j].x=p[i].x) and (a[j].y<p[i].y))) do inc(j);
                if (a[j].x=p[i].x) and (a[j].y=p[i].y) then dec(res[(v[i]-1) div 4+1]);
        end;
        for i:=1 to m do writeln(res[i]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        result;
        close(input);close(output);
end.
