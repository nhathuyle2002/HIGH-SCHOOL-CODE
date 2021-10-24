const   ginp='ss.inp';
        gout='ss.out';
        maxn=100010;

var     gi,go:text;
        n,cou:longint;
        mins,maxs,res:int64;
        a,b,c:array[0..maxn] of int64;
        f:array[0..maxn*12] of longint;
        d:array[-1..maxn*3] of int64;
        v,la:array[-1..maxn*3] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n,mins,maxs);
        a[0]:=0;
        for i:=1 to n do
        begin
                read(gi,a[i]);
                a[i]:=a[i-1]+a[i];
                b[i]:=a[i]-mins;
                c[i]:=a[i]-maxs;
        end;
end;

procedure sort(l,r:longint);
var     i,j,tm1:longint;
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
                        tm1:=v[i];v[i]:=v[j];v[j]:=tm1;
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
        build(id shl 1,l,m);
        build(id shl 1+1,m+1,r);
end;

function quece(id,l,r,d,c:longint):longint;
var     m:longint;
begin
        if (d>r) or (c<l) then exit(0);
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) shr 1;
        quece:=quece(id*2,l,m,d,c)+quece(id*2+1,m+1,r,d,c);
end;

procedure update(id:longint);
begin
        if id<1 then exit;
        inc(f[id]);
        update(id shr 1);
end;

procedure process;
var     i:longint;
begin
        for i:=0 to n do
        begin
                d[i]:=a[i];v[i]:=i;
                d[i+n+1]:=b[i];v[i+n+1]:=i+n+1;
                d[i+(n+1)*2]:=c[i];v[i+(n+1)*2]:=i+(n+1)*2;
        end;
        sort(0,n+(n+1)*2);
        cou:=0;
        for i:=0 to n+(n+1)*2 do
        begin
                if d[i]>d[i-1] then inc(cou);
                if v[i]<n+1 then a[v[i]]:=cou else
                if v[i]<(n+1)*2 then b[v[i]-n-1]:=cou else
                c[v[i]-(n+1)*2]:=cou;
        end;
        fillchar(f,sizeof(f),0);
        build(1,0,cou);
        for i:=0 to n do
        begin
                res:=res+quece(1,0,cou,c[i],b[i]);
                update(la[a[i]]);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,res);
        close(gi);close(go);
end.
