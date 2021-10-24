const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,xmax,ymax,m:longint;
        x,y,z,v,la:array[0..100001] of longint;
        f:array[0..400001] of int64;

function max(xx,yy:int64):int64;
begin
        if xx>yy then exit(xx) else exit(yy);
end;

procedure swap(var xx,yy:longint);
var     tm:longint;
begin
        tm:=xx;xx:=yy;yy:=tm;
end;

procedure sort(l,r:longint);
var     i,j,tm1,tm2:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tm1:=random(r-l+1)+l;
        tm2:=y[tm1];tm1:=x[tm1];
        repeat
                while (x[i]<tm1) or ((x[i]=tm1) and (y[i]<tm2)) do inc(i);
                while (x[j]>tm1) or ((x[j]=tm1) and (y[j]>tm2)) do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);swap(y[i],y[j]);swap(z[i],z[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure sort2(l,r:longint;var a,b:array of longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);swap(b[i],b[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort2(l,j,a,b);sort2(i,r,a,b);
end;

procedure build(id,l,r:longint);
var     mid:longint;
begin
        if l=r then
        begin
                la[l]:=id;
                exit;
        end;
        mid:=(l+r) div 2;
        build(id*2,l,mid);
        build(id*2+1,mid+1,r);
end;

procedure update(id:longint;x:int64);
begin
        if id<1 then exit;
        f[id]:=max(f[id],x);
        update(id div 2,x);
end;

function quece(id,l,r,d,c:longint):int64;
var     mid:longint;
begin
        if (l>r) then exit(0);
        if (d>r) or (c<l) then exit(0);
        if (d<=l) and (r<=c) then exit(f[id]);
        mid:=(l+r) div 2;
        quece:=max(quece(id*2,l,mid,d,c),quece(id*2+1,mid+1,r,d,c));
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,xmax,ymax,n);
        for i:=1 to n do readln(gi,x[i],y[i],z[i]);
end;

procedure create;
var     i:longint;
        y0,vt:array[0..100001] of longint;
begin
        sort(1,n);
        y0:=y;
        for i:=1 to n do vt[i]:=i;
        sort2(1,n,y0,vt);
        m:=0;y0[0]:=0;
        for i:=1 to n do
        begin
                if y0[i]<>y0[i-1] then inc(m);
                v[vt[i]]:=m;
        end;
        build(1,1,m);
end;

procedure output;
var     i:longint;
        tm:int64;
begin
        for i:=1 to n do
        begin
                tm:=quece(1,1,m,1,v[i]);
                update(la[v[i]],tm+z[i]);
        end;
        write(go,f[1]);
        close(gi);close(go);
end;

begin
        input;
        create;
        output;
end.
