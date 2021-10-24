const   ginp='ss.inp';
        gout='ss.out';
        vc=trunc(1e17);

type    things=record w,t:int64;end;

var     gi,go:text;
        n,m,n0,m0:longint;
        minw,maxw,res:int64;
        a:array[0..20] of things;
        c,d:array[0..70000] of things;
        f:array[0..4*70000] of int64;
        dd:array[0..20] of longint;


procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,minw,maxw);
end;

procedure try(i:longint);
var     j:longint;
begin
        if i=m+1 then
        begin
                inc(n0);d[n0].w:=0;d[n0].t:=0;
                for j:=1 to m do
                        if dd[j]=1 then
                        begin
                                d[n0].w:=d[n0].w+a[j].w;
                                d[n0].t:=d[n0].t+a[j].t;
                        end;
                exit;
        end;
        for j:=0 to 1 do
        begin
                dd[i]:=j;
                try(i+1);
        end;
end;

procedure create;
var     i:longint;
begin
        m:=n div 2;n0:=0;
        for i:=1 to m do readln(gi,a[i].w,a[i].t);
        try(1);m0:=n0;for i:=1 to m0 do c[i]:=d[i];
        m:=n-n div 2;n0:=0;
        for i:=1 to m do readln(gi,a[i].w,a[i].t);
        try(1);
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:things;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i].w<t.w do inc(i);
                while d[j].w>t.w do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                f[id]:=d[l].t;
                exit;
        end;
        m:=(l+r) div 2;
        build(id*2,l,m);build(id*2+1,m+1,r);
        f[id]:=max(f[id*2],f[id*2+1]);
end;

function quece(id,l,r,d,c:longint):int64;
var     m:longint;
begin
        if (l>r) or (d>r) or (c<l) then exit(0);
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) div 2;
        quece:=max(quece(id*2,l,m,d,c),quece(id*2+1,m+1,r,d,c));
end;

function cnp1(x:int64):longint;
var     l,r,m:longint;
begin
        l:=1;r:=n0+1;
        while l<>r do
        begin
                m:=(l+r) div 2;
                if d[m].w<=x then l:=m+1 else r:=m;
        end;
        exit(l-1);
end;

function cnp2(x:int64):longint;
var     l,r,m:longint;
begin
        l:=1;r:=n0;
        while l<>r do
        begin
                m:=(l+r) div 2;
                if d[m].w<x then l:=m+1 else r:=m;
        end;
        exit(l);
end;

procedure process;
var     i,tm1,tm2:longint;
begin
        sort(1,n0);
        res:=0;d[0].w:=-vc;d[n0+1].w:=vc;
        build(1,1,n0);
        for i:=1 to m0 do
                if (maxw-c[i].w>=0) and (c[i].w+d[n0].w>=minw) then
                begin
                        tm1:=cnp1(maxw-c[i].w);
                        tm2:=cnp2(minw-c[i].w);
                        if tm2<=tm1 then res:=max(res,quece(1,1,n0,tm2,tm1)+c[i].t);
                end;
end;

procedure output;
begin
        write(go,res);
        close(gi);close(go);
end;

begin
        input;
        create;
        process;
        output;
end.
