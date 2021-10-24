const   fi='GHEPCAP.INP';
        fo='GHEPCAP.OUT';
var     n:longint;
        a:array[0..100009] of int64;
        g:text;
        kq:int64;
procedure nhap;
var i:longint;
begin
        assign(g,fi);
        reset(g);
        readln(g,n);
        for i:=1 to n do read(g,a[i]);
        close(g);
end;

procedure qs(l,r:longint);
var i,j,t,x:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=a[random(r-l+1)+l];
        repeat
        while a[i]<x do inc(i);
        while a[j]>x do dec(j);
        if i<=j then
        begin
                t:=a[i];
                a[i]:=a[j];
                a[j]:=t;
                inc(i);dec(j);
        end;
        until i>j;
        qs(l,j);qs(i,r);
end;

function np(x:double):longint;
var  d,c,mid:longint;
begin
        d:=1;
        c:=n;
        while d<c do
        begin
                mid:=(d+c) div 2;
                if a[mid]<x then d:=mid+1 else c:=mid;
        end;
        exit(d);
end;

procedure main;
var x:double;
        t,i:longint;

begin
        kq:=0;    a[n+1]:=maxlongint;
        for i:=1 to n-1 do
        begin
                x:=a[i]*10/9;
                t:=np(x);
                while a[t+1]<=x do inc(t);
                while a[t]>x do dec(t);
                kq:=kq+t-i;
        end;
end;

procedure xuat;
begin
        assign(g,fo);
        rewrite(g);
        write(g,kq);
        close(g);
end;

begin
        nhap;
        qs(1,n);
        main;
        xuat;
end.
