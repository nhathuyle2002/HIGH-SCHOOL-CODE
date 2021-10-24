const   ginp='ss.inp';
        gout='ss.out';
        maxg=200;

var     gi,go:text;
        n,re:longint;
        x,y,s,v:array[0..1501] of longint;
        d:array[0..1501] of real;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,x[i],y[i],s[i]);
                s[i]:=s[i]*s[i]+5;
        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure sort(l,r:longint);
var     i,j,tm2:longint;
        t,tm1:real;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tm1:=d[i];d[i]:=d[j];d[j]:=tm1;
                        tm2:=v[i];v[i]:=v[j];v[j]:=tm2;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i,j,tm1,tm2,gt,su:longint;
begin
        re:=0;d[n+1]:=-maxg;
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        if i=j then d[j]:=-maxg else
                        begin
                                tm1:=x[i]-x[j];
                                tm2:=y[i]-y[j];
                                if tm2=0 then d[j]:=maxg else d[j]:=tm1/tm2;
                        end;
                        v[j]:=j;
                end;
                sort(1,n);
                gt:=0;su:=0;
                for j:=2 to n+1 do
                        if d[j]<>d[j-1] then
                        begin
                                gt:=max(gt,su);
                                su:=s[v[j]];
                        end else su:=su+s[v[j]];
                re:=max(re,gt+s[i]);
        end;
end;

begin

        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,re);
        close(gi);close(go);
end.
