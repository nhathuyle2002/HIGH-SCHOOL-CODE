const   ginp='merlin.inp';
        gout='merlin.out';

var     gi,go:text;
        n,ans:longint;
        sum,a:array[0..100001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure sort(l,r:longint);
var     i,j:longint;
        x,tmp:int64;
begin
        if l>=r then exit;
        x:=a[random(r-l+1)+l];
        i:=l;j:=r;
        repeat
                while a[i]<x do inc(i);
                while a[j]>x do dec(j);
                if i<=j then
                begin
                        tmp:=a[i];
                        a[i]:=a[j];
                        a[j]:=tmp;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i:longint;
begin
        for i:=1 to n do sum[i]:=sum[i-1]+a[i];
        for i:=1 to n do
        begin
                if (a[i]*i)<=(sum[n]) then ans:=i
                else break;
        end;
        ans:=n-ans;
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