const   ginp='bai1.inp';
        gout='bai1.out';

var      gi,go:text;
         n:longint;
         res:int64;
         a:array[0..5001] of longint;

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

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
        sort(1,n);
end;

procedure main;
var     i,l,r:longint;
begin
        res:=0;
        for i:=3 to n do
        begin
                l:=1;r:=i-1;
                repeat
                        while (l<r) and (a[l]+a[r]<=a[i]) do inc(l);
                        res:=res+r-l;
                        dec(r);
                until l>=r;
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        main;
        close(gi);close(go);
end.






