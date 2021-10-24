const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n:longint;
        a,b,c,d,va,vc:array[0..10010] of longint;

procedure input;
var     i,nm:longint;
        x,y:array[0..10010] of longint;
begin
        readln(gi,nm);
        for i:=1 to nm do read(gi,x[i]);readln(gi);
        for i:=1 to nm do read(gi,y[i]);
        for i:=1 to nm do
                if x[i]<=y[i] then
                begin
                        inc(m);a[m]:=x[i];b[m]:=y[i];va[m]:=i;
                end else
                begin
                        inc(n);c[n]:=x[i];d[n]:=y[i];vc[n]:=i;
                end;
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort1(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);swap(b[i],b[j]);swap(va[i],va[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort1(l,j);sort1(i,r);
end;

procedure sort2(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]>t do inc(i);
                while d[j]<t do dec(j);
                if i<=j then
                begin
                        swap(c[i],c[j]);swap(d[i],d[j]);swap(vc[i],vc[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort2(l,j);sort2(i,r);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,s1,s2:longint;
begin
        sort1(1,m);
        sort2(1,n);
        s1:=0;s2:=0;
        for i:=1 to m do
        begin
                s1:=s1+a[i];
                s2:=max(s2,s1)+b[i];
        end;
        for i:=1 to n do
        begin
                s1:=s1+c[i];
                s2:=max(s2,s1)+d[i];
        end;
        writeln(go,s2);
        for i:=1 to m do write(go,va[i],' ');
        for i:=1 to n do write(go,vc[i],' ');
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
