const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m:longint;
        ans:int64;
        x,y,z:array[0..100100] of int64;
        pa:array[0..100100] of longint;
        cs,u,v:array[0..300100] of longint;
        w:array[0..300100] of int64;

procedure sort(l,r:longint;var d:array of int64);
var     i,j,tmp:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        tmp:=cs[i];cs[i]:=cs[j];cs[j]:=tmp;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure sorts(l,r:longint);
var     i,j,tmp:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=w[random(r-l+1)+l];
        repeat
                while w[i]<t do inc(i);
                while w[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=w[i];w[i]:=w[j];w[j]:=tm;
                        tmp:=u[i];u[i]:=u[j];u[j]:=tmp;
                        tmp:=v[i];v[i]:=v[j];v[j]:=tmp;
                        inc(i);dec(j);
                end;
        until i>j;
        sorts(l,j);sorts(i,r);
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,x[i],y[i],z[i]);
end;

procedure create(var d:array of int64);
var     i:longint;
begin
        for i:=1 to n do cs[i]:=i;
        sort(1,n,d);
        d[n+1]:=d[1];
        for i:=1 to n do
        begin
                inc(m);
                u[m]:=cs[i];
                v[m]:=cs[i+1];
                w[m]:=abs(d[i+1]-d[i]);
        end;
end;

function root(p:longint):longint;
begin
        while p<>pa[p] do p:=pa[p];
        root:=p;
end;

procedure process;
var     i,u0,v0,cou:longint;
begin
        m:=0;
        create(x);
        create(y);
        create(z);
        sorts(1,m);
        for i:=1 to n do pa[i]:=i;
        ans:=0;cou:=0;
        for i:=1 to m do
        begin
                if cou=n-1 then exit;
                u0:=root(u[i]);
                v0:=root(v[i]);
                if u0<>v0 then
                begin
                        inc(cou);
                        pa[v0]:=u0;
                        pa[v[i]]:=u0;
                        ans:=ans+w[i];
                end;
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.


