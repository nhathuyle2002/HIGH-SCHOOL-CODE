const   ginp='buygifts.inp';
        gout='buygifts.out';

var     gi,go:text;
        n,m:longint;
        a:array[0..100001] of longint;
        ans:longint;

procedure swap(var x,y:longint);
var     tmp:longint;
begin
        tmp:=x;
        x:=y;
        y:=tmp;
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        if m>n then swap(n,m);
        for i:=1 to n do read(gi,a[i]);
end;

procedure sort(l,r:longint);
var     i,j,x:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=a[random(r-l+1)+l];
        repeat
                while a[i]<x do inc(i);
                while a[j]>x do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);
        sort(i,r);
end;

procedure output;
var     i:longint;
begin
        ans:=maxlongint;
        for i:=m to n do
                if ans>a[i]-a[i-m+1] then ans:=a[i]-a[i-m+1];
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        output;
end.
