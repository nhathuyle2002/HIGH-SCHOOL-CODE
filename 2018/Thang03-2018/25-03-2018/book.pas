const   ginp='book.inp';
        gout='book.out';

var     gi,go:text;
        n:longint;
        a:array[0..100001] of longint;
        ans:int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i]);
end;

procedure sort(l,r:longint);
var     i,j,tmp,x:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=a[random(r-l+1)+l];
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
var     i,dem:longint;
begin
        dem:=0;
        i:=n;ans:=0;
        while i>0 do
        begin
                if dem mod 3<>2 then ans:=ans+a[i];
                inc(dem);dec(i);
        end;
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