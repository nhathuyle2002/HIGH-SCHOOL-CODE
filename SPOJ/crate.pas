const   ginp='ss.inp';
        gout='ss.out';

type    mang=record t,h,cs:longint;end;

var     gi,go:text;
        n,top,tm,maxa:longint;
        a:array[0..300010] of mang;
        la:array[0..100010] of longint;
        dp:array[0..500000] of longint;
        d:array[0..300010] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        maxa:=0;
        for i:=1 to n do
        begin
                readln(gi,a[i].t,a[i].h);
                if a[i].h>maxa then maxa:=a[i].h;
                a[i].cs:=i;
        end;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        x,tm:mang;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=a[random(r-l+1)+l];
        repeat
                while (a[i].t<x.t) or ((a[i].t=x.t) and (a[i].h<x.h)) do inc(i);
                while (a[j].t>x.t) or ((a[j].t=x.t) and (a[j].h>x.h)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                la[l]:=id;
                exit;
        end;
        m:=(l+r) div 2;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
end;

procedure upt(id:longint);
begin
        if id=0 then exit;
        inc(dp[id]);
        upt(id div 2);
end;

function get(id,l,r,d,c:longint):longint;
var     m:longint;
begin
        if (l>r) then exit(0);
        if (l>c) or (r<d) then exit(0);
        if (d<=l) and (r<=c) then exit(dp[id]);
        m:=(l+r) div 2;
        exit(get(id*2,l,m,d,c)+get(id*2+1,m+1,r,d,c));
end;

procedure process;
var     i:longint;
begin
        build(1,0,maxa);
        for i:=1 to n do
        begin
                if (a[i].h=a[i-1].h) and (a[i].t=a[i-1].t) then d[a[i].cs]:=d[a[i-1].cs]
                else d[a[i].cs]:=get(1,0,maxa,0,a[i].h);
                upt(la[a[i].h]);
        end;
end;

procedure output;
var     i:longint;
begin
        for i:=1 to n do writeln(go,d[i]);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.

