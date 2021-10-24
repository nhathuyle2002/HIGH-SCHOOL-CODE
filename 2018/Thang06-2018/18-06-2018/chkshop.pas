const   ginp='chkshop.inp';
        gout='chkshop.out';

var     gi,go:text;
        n:longint;
        a,b:array[0..100010] of int64;

procedure sort(l,r:longint;var d:array of int64);
var     i,j:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure main;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);readln(gi);
        for i:=1 to n do read(gi,b[i]);
        sort(1,n,a);
        sort(1,n,b);
        for i:=1 to n do
                if a[i]<>b[i] then
                begin
                        write(go,'NO');
                        exit;
                end;
        write(go,'YES');
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
