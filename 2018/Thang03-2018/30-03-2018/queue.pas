const   ginp='queue.inp';
        gout='queue.out';

var     gi,go:text;
        n:longint;
        a:array[0..100001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure swap(var x,y:longint);
var     tmp:longint;
begin
        tmp:=x;
        x:=y;
        y:=tmp;
end;

procedure sort(l,r:longint);
var     i,j,x:longint;
begin
        if l>=r then exit;
        x:=a[random(r-l+1)+l];
        i:=l;j:=r;
        repeat
                while a[i]<x do inc(i);
                while a[j]>x do dec(j);
                if i<=j then
                begin
                        if a[i]<>a[j] then
                        begin
                                writeln(go,i,' ',j);
                                swap(a[i],a[j]);
                        end;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        output;
end.
