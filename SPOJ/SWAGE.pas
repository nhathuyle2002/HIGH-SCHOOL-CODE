const   fi='SWAGE.INP';
        fo='SWAGE.OUT';
var     N,d1,d2,kq,tg:LONGINT;
        x,y:array[0..2009] of longint;
        a:array[0..2009] of double;
        g:text;
procedure nhap;
var i:longint;
begin
        assign(g,fi);
        reset(g);
        readln(g,n);
        for i:=1 to n do readln(g,x[i],y[i]);
        close(g);
end;

procedure kiemtra;
var i,j:longint;
begin
        i:=1;
        while i<=n do
        begin
                j:=i;
                while a[i+1]=a[i] do inc(i);
                if (a[j]<>-maxlongint) and (i-j+2+tg>kq) then kq:=i-j+2+tg;
                inc(i);
        end;
        if d1+1>kq then kq:=d1+1;
        if d2+1>kq then kq:=d2+1;
end;

procedure qs(l,r:longint);
var i,j:longint;
        t,x:double;
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
                inc(i);
                dec(j);
        end;
        until i>j;
        qs(l,j);qs(i,r);
end;

procedure main;
var i,j:longint;
begin
        kq:=0;  a[n+1]:=-maxlongint;
        for i:=1 to n do
        begin
                d1:=0;d2:=0;tg:=0;
                for j:=1 to n do
                begin
                        a[j]:=-maxlongint;
                        if i<>j then
                        begin
                                if (x[j]=x[i] )or (y[i]=y[j]) then
                                begin
                                        if x[j]=x[i] then inc(d1);
                                        if y[j]=y[i] then inc(d2);
                                        if (x[j]=x[i]) and (y[i]=y[j]) then inc(tg);
                                end
                                else
                                a[j]:=(x[j]-x[i])/(y[i]-y[j]);
                        end;
                end;
                qs(1,n);
                kiemtra;
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
        main;
        xuat;
end.
