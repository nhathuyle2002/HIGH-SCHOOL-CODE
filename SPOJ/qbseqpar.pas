const   ginp='ss.inp';
        gout='ss.out';
        maxn=15010;
        maxg=maxn*30000;

type    giatri=record ma,mi:longint;end;

var     gi,go:text;
        n,k,dau,cuoi,g,cou:longint;
        a,b,c:array[0..maxn] of longint;
        d,v,la:array[-1..2*maxn] of longint;
        f:array[0..8*maxn] of giatri;

procedure input;
var     i:longint;
begin
        readln(gi,n,k);
        a[0]:=0;
        for i:=1 to n do
        begin
                readln(gi,a[i]);
                a[i]:=a[i-1]+a[i];
        end;
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        swap(d[i],d[j]);swap(v[i],v[j]);
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
        m:=(l+r) shr 1;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure update(id:longint;x:giatri);
begin
        if id<1 then exit;
        f[id].mi:=min(f[id].mi,x.mi);
        f[id].ma:=max(f[id].ma,x.ma);
        update(id shr 1,x);
end;

function quece(id,l,r,d,c:longint):giatri;
var     m:longint;
        tm1,tm2:giatri;
begin
        if (d>r) or (c<l) then
        begin
                quece.mi:=maxg;
                quece.ma:=-maxg;
                exit;
        end;
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) shr 1;
        tm1:=quece(id*2,l,m,d,c);
        tm2:=quece(id*2+1,m+1,r,d,c);
        quece.mi:=min(tm1.mi,tm2.mi);
        quece.ma:=max(tm1.ma,tm2.ma);
end;

function check:boolean;
var     i:longint;
        tm:giatri;
begin
        b:=a;
        for i:=0 to n do c[i]:=b[i]-g;
        for i:=0 to n do
        begin
                d[i]:=b[i];v[i]:=i;
                d[i+n+1]:=c[i];v[i+n+1]:=i+n+1;
        end;
        sort(0,2*n+1);
        cou:=0;
        for i:=0 to 2*n+1 do
        begin
                if d[i]>d[i-1] then inc(cou);
                if v[i]<n+1 then b[v[i]]:=cou
                else c[v[i]-n-1]:=cou;
        end;
        for i:=0 to cou*4 do
        begin
                f[i].mi:=maxg;
                f[i].ma:=-maxg;
        end;
        build(1,0,cou);
        tm.mi:=0;tm.ma:=0;
        update(la[b[0]],tm);
        for i:=1 to n do
        begin
                tm:=quece(1,0,cou,c[i],cou);
                inc(tm.mi);inc(tm.ma);
                update(la[b[i]],tm);
        end;
        if (tm.mi<=k) and (tm.ma>=k) then exit(true) else exit(false);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        dau:=-maxg;cuoi:=maxg;
        while dau<>cuoi do
        begin
                g:=(dau+cuoi) shr 1;
                if check then cuoi:=g else dau:=g+1;
        end;
        write(go,dau);
        close(gi);close(go);
end.
