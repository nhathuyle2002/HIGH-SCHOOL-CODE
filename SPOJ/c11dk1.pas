const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e9)+10;

var     gi,go:text;
        n,m:longint;
        a,d,c:array[0..10010] of longint;
        f:array[0..10010] of longint;

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
                        swap(a[i],a[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort1(l,j);sort1(i,r);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure sort2(l,r:longint);
var     i,j,t1,t2:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t1:=random(r-l+1)+l;
        t2:=c[t1];t1:=d[t1];
        repeat
                while (d[i]<t1) or ((d[i]=t1) and (c[i]>t2)) do inc(i);
                while (d[j]>t1) or ((d[j]=t1) and (c[j]<t2)) do dec(j);
                if i<=j then
                begin
                        swap(d[i],d[j]);
                        swap(c[i],c[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort2(l,j);sort2(i,r);
end;

function cnp(x:longint):longint;
var     mid,l,r:longint;
begin
        l:=1;r:=n;
        while l<>r do
        begin
                mid:=(l+r) shr 1;
                if a[mid]<=x then l:=mid+1 else r:=mid;
        end;
        exit(l);
end;

procedure input;
var     i,mm:longint;
begin
        readln(gi,n,m);
        for i:=1 to n do readln(gi,a[i]);
        sort1(1,n);
        for i:=1 to m do
        begin
                readln(gi,d[i],c[i]);
                d[i]:=2*d[i]+1;
        end;
        sort2(1,m);
        mm:=0;
        for i:=1 to m do
        begin
                while (mm>0) and (c[i]<=c[mm]) do dec(mm);
                inc(mm);d[mm]:=d[i];c[mm]:=c[i];
        end;
        m:=mm;
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to n do
        begin
                f[i]:=oo;
                for j:=1 to m do
                        f[i]:=min(f[i],f[cnp(a[i]-d[j])-1]+c[j]);
        end;
        write(go,f[n]);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
