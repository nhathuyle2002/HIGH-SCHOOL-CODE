const   ginp='pigbank.inp';
        gout='pigbank.out';

var     gi,go:text;
        n:longint;
        a,d:array[0..100001] of longint;

procedure input;
var     i,l,r,m:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,l,r);
                d[l]:=d[l]+1;;d[r+1]:=d[r+1]-1;
        end;
        for i:=1 to n do a[i]:=a[i-1]+d[i];
end;

procedure swap(var x,y:longint);
var     tmp:longint;
begin
        tmp:=x;
        x:=y;
        y:=tmp;
end;

procedure sort(l,r:longint);
var     i,j,x:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=a[random(r-l+1)+l];
        repeat
                while a[i]<x do inc(i);
                while a[j]>x do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function cnp(x:longint):longint;
var     d,c,m:longint;
begin
        d:=1;c:=n;
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                if a[m]>=x then c:=m else d:=m;
                m:=(d+c) div 2;
        end;
        for m:=d to c do
                if a[m]>=x then exit(n-m+1);
        exit(0);
end;

procedure process;
var     i,x,q,tmp:longint;
begin
        readln(gi,q);
        for i:=1 to q do
        begin
                readln(gi,x);
                writeln(go,cnp(x));
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.











