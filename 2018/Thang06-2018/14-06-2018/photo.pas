const   ginp='photo.inp';
        gout='photo.out';
        maxn=100010;

var     gi,go:text;
        n:longint;
        v:array[1..5,0..maxn] of longint;
        a:array[0..maxn] of longint;

function sosanh(x,y:longint):boolean;
var     i,cou:longint;
begin
        cou:=0;
        for i:=1 to 5 do
                if v[i,x]<v[i,y] then inc(cou);
        if cou>=3 then exit(true) else exit(false);
end;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while sosanh(a[i],t) do inc(i);
                while sosanh(t,a[j]) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure main;
var     i,j,x:longint;
begin
        readln(gi,n);
        for i:=1 to 5 do
        begin
                for j:=1 to n do
                begin
                        read(gi,x);
                        v[i,x]:=j;
                end;
                readln(gi);
        end;
        for i:=1 to n do a[i]:=i;
        sort(1,n);
        for i:=1 to n do write(go,a[i],' ');
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
