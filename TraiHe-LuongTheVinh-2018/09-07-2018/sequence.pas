const   ginp='sequence.inp';
        gout='sequence.out';
        oo=trunc(1e9)+2;
        ooo=trunc(1e16);

var     n,k:longint;
        a,v:array[0..100010] of longint;
        g,s,f:array[0..100010] of int64;

procedure enter;
var     i:longint;
begin
        readln(n,k);
        for i:=1 to n do read(a[i]);
end;

procedure sort(l,r:longint);
var     i,j,tt,t2:longint;
        t1,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t2:=random(r-l+1)+l;
        t1:=g[t2];t2:=v[t2];
        repeat
                while (g[i]<t1) or ((g[i]=t1) and (v[i]<t2)) do inc(i);
                while (g[j]>t1) or ((g[j]=t1) and (v[j]>t2)) do dec(j);
                if i<=j then
                begin
                        tm:=g[i];g[i]:=g[j];g[j]:=tm;
                        tt:=v[i];v[i]:=v[j];v[j]:=tt;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure update(i:longint;x:int64);
begin
        if i>n then exit;
        if f[i]>x then
        begin
                f[i]:=x;
                update(i+i and (-i),x);
        end;
end;

function quece(i:longint):int64;
var     tm:int64;
begin
        if i<1 then exit(ooo);
        tm:=quece(i-i and (-i));
        if tm>f[i] then exit(f[i]) else exit(tm);
end;

function check(kk:longint):boolean;
var     i:longint;
begin
        for i:=1 to n do
                if (s[i] div i>=kk) and (s[i]>=k) then exit(true);
        for i:=1 to n do
        begin
                g[i]:=g[i-1]+a[i]-kk;
                v[i]:=i;
        end;
        sort(1,n);
        for i:=1 to n do f[i]:=ooo;
        for i:=1 to n do
        begin
                if s[v[i]]-quece(v[i])>=k then exit(true);
                update(v[i],s[v[i]]);
        end;
        exit(false);
end;

procedure process;
var     d,c,m,i:longint;
begin
        for i:=1 to n do s[i]:=s[i-1]+a[i];
        d:=1;c:=oo;
        while d<c do
        begin
                m:=(d+c) shr 1;
                if check(m) then d:=m+1 else c:=m;
        end;
        write(d-1);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.

