const   ginp='muaqua.inp';
        gout='muaqua.out';

var     gi,go:text;
        n,m,ans:longint;
        a:array[0..1000001] of longint;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure main;
var     i,tm:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to n do read(gi,a[i]);
        sort(1,n);
        ans:=maxlongint;
        for i:=m to n do
        begin
                tm:=a[i]-a[i-m+1];
                if tm<ans then ans:=tm;
        end;
        write(go,ans);
        close(gi);close(go);
end;

begin
        main;
end.





