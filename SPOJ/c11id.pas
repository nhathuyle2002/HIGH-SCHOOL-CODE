const   ginp='ss.inp';
        gout='ss.out';
        k=round(1e9)+7;

var     gi,go:text;
        n:longint;
        re:int64;
        a:array[0..100001] of int64;

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

procedure process;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i]);
        sort(1,n);
        re:=1;
        for i:=1 to n do
                if a[i]-i+1<=0 then
                begin
                        re:=0;
                        exit;
                end else re:=re*(a[i]-i+1) mod k;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        process;
        write(go,re);
        close(gi);close(go);
end.
