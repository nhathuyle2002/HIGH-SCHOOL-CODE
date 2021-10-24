const   ginp='xephcn.inp';
        gout='xephcn.out';

var     gi,go:text;
        n,r,ans:longint;
        a,b,l:array[0..1000001] of longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,a[i],b[i]);
                if a[i]>b[i] then swap(a[i],b[i]);
        end;
end;

procedure sort(l,r:longint);
var     i,j,ta,tb:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        ta:=random(r-l+1)+l;
        tb:=b[ta];ta:=a[ta];
        repeat
                while (b[i]<tb) or ((b[i]=tb) and (a[i]>ta)) do inc(i);
                while (b[j]>tb) or ((b[j]=tb) and (a[j]<ta)) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure cnp(x:longint);
var     d,c,m:longint;
begin
        d:=1;c:=r;
        while (d<c) do
        begin
                m:=(d+c) div 2;
                if l[m]<x then d:=m+1 else c:=m;
        end;
        l[d]:=x;
end;

procedure process;
var     i:longint;
begin
        l[0]:=-maxlongint;
        r:=1;l[1]:=a[1];
        for i:=2 to n do
                if a[i]>l[r] then
                begin
                        inc(r);
                        l[r]:=a[i];
                end
                else cnp(a[i]);
        ans:=r;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.






