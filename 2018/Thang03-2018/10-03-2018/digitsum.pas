const   ginp='digitsum.inp';
        gout='digitsum.out';

var     gi,go:text;
        n,t:Longint;
        a:array[0..100] of int64;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
end;

procedure swap(var x,y:int64);
var     tam:int64;
begin
        tam:=x;
        x:=y;
        y:=tam;
end;

procedure sort(l,r:longint);
var     i,j,x,tam:longint;
begin
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
        if l<j then sort(l,j);
        if i<r then sort(i,r);
end;

procedure ccl;
var     i:longint;
        sum1,sum2:int64;
begin
        sum1:=0;sum2:=0;
        for i:=1 to n do
                if i mod 2=1 then sum1:=sum1*10+a[i] else sum2:=sum2*10+a[i];
        writeln(go,sum1+sum2);
end;

procedure process;
var     i,k:longint;
begin
        for k:=1 to t do
        begin
                read(gi,n);
                for i:=1 to n do read(gi,a[i]);
                sort(1,n);
                i:=1;
                while a[i]=0 do inc(i);
                swap(a[1],a[i]);
                i:=2;
                while a[i]=0 do inc(i);
                swap(a[2],a[i]);
                readln(gi);
                ccl;
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
