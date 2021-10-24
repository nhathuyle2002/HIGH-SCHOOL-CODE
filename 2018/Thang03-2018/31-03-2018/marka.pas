const   ginp='marka.inp';
        gout='marka.out';

var     gi,go:text;
        n,m:longint;
        a,b:array[0..1000001] of longint;
        ans:int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to n do read(gi,a[i]);
        readln(gi);
        for i:=1 to m do read(gi,b[i]);
end;

procedure sort(l,r:longint;var d:array of longint);
var     i,j,tm,x:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=d[random(r-l+1)+l];
        repeat
                while d[i]<x do inc(i);
                while d[j]>x do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure process;
var     i,j:longint;
begin
        j:=0;b[0]:=-maxlongint;
        for i:=1 to n do
        begin
                while (a[i]>b[j+1]) and (j<m) do inc(j);
                ans:=ans+j;
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n,a);
        sort(1,m,b);
        process;
        output;
end.

