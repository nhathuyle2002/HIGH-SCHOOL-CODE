const   ginp='express.inp';
        gout='express.out';

var     gi,go:text;
        n,k:longint;
        ans:int64;
        a:array[0..100001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do read(gi,a[i]);
end;

procedure sort(l,r:longint);
var     i,j,tm,x:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=a[random(r-l+1)+l];
        repeat
                while a[i]<x do inc(i);
                while a[j]>x do dec(j);
                if i<=j then
                begin
                        tm:=a[i];
                        a[i]:=a[j];
                        a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i:longint;
begin
        ans:=a[1];
        for i:=n downto n-k+1 do
                ans:=ans+a[i];
        for i:=n-k downto 2 do
                ans:=ans-a[i];
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(2,n);
        process;
        output;
end.
