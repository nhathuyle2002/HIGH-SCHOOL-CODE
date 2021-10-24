const   ginp='ghepcap.inp';
        gout='ghepcap.out';

var     gi,go:text;
        n:longint;
        dem:int64;
        a:array[0..100001] of int64;

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
        if l<j then sort(l,j);
        if i<r then sort(i,r);
end;

function cnp(i:longint;x:extended):longint;
var     d,c,m:longint;
begin
        d:=i+1;c:=n;
        if d>c then exit(0);
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                if a[m]<=x then c:=m else d:=m+1;
                m:=(d+c) div 2;
        end;
        for m:=c downto d do
                if x<=a[m] then exit(m-i);
        exit(0);
end;

procedure process;
var     i,tam2:longint;
        tmp:extended;
begin
        dem:=0;
        for i:=2 to n-1 do
        begin
                tmp:=a[i]*100/90;
                dem:=dem+cnp(i,tmp);
        end;
end;

procedure output;
begin
        write(go,dem);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.
