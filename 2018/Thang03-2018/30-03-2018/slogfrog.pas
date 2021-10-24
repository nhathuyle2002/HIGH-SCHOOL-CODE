const   ginp='slogfrog.inp';
        gout='slogfrog.out';

var     gi,go:text;
        n,m,k:longint;
        ans:int64;
        a:array[0..100001] of longint;
        d:array[-100001..100001] of longint;

procedure input;
var     i,j,x:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(gi,x);
                        inc(d[x]);
                end;
                readln(gi);
        end;
end;

procedure create;
var     i:longint;
begin
        n:=0;
        for i:=-100001 to 100001 do
                if d[i]<>0 then
                begin
                        inc(n);
                        a[n]:=d[i];
                end;
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
        ans:=0;
        if k>n then k:=n;
        for i:=n downto n-k+1 do
                ans:=ans+a[i];
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        create;
        sort(1,n);
        process;
        output;
end.


