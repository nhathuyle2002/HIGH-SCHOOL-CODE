const   ginp='employ.inp';
        gout='employ.out';
        maxn=100100;
        oo=trunc(1e15);

type    save=record g:int64;v:longint;end;

var     gi,go:text;
        n,maxt:longint;
        a,b,c,trace:array[0..maxn] of longint;
        g,v,la:array[0..2*maxn] of longint;
        f:array[0..4*maxn] of save;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=g[random(r-l+1)+l];
        repeat
                while g[i]<t do inc(i);
                while g[j]>t do dec(j);
                if i<=j then
                begin
                        swap(g[i],g[j]);
                        swap(v[i],v[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure qsort(l,r:longint);
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
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        swap(c[i],c[j]);
                        swap(v[i],v[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        qsort(l,j);qsort(i,r);
end;

procedure input;
var     i,cou:longint;
begin
        readln(gi,n,maxt);
        for i:=1 to n do readln(gi,a[i],b[i],c[i]);
        for i:=1 to n do
        begin
                v[i]:=i;g[i]:=a[i];
        end;
        for i:=n+1 to 2*n do
        begin
                v[i]:=i;g[i]:=b[i-n];
        end;
        v[2*n+1]:=2*n+1;g[2*n+1]:=maxt;
        sort(1,2*n+1);
        cou:=1;
        for i:=1 to 2*n+1 do
        begin
                if g[i]>g[i-1] then inc(cou);
                if v[i]<=n then a[v[i]]:=cou else
                if v[i]<=2*n then b[v[i]-n]:=cou
                else maxt:=cou;
        end;
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                la[l]:=id;
                f[id].g:=oo;
                exit;
        end;
        m:=(l+r) shr 1;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
        f[id].g:=oo;
end;

function quece(id,l,r,d,c:longint):save;
var     m:longint;
        tm1,tm2:save;
begin
        if (d>r) or (c<l) then
        begin
                quece.g:=oo;
                exit;
        end;
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) shr 1;
        tm1:=quece(id*2,l,m,d,c);
        tm2:=quece(id*2+1,m+1,r,d,c);
        if tm1.g<tm2.g then quece:=tm1 else quece:=tm2;
end;

procedure update(id,i:longint;gt:int64);
begin
        if id=0 then exit;
        if f[id].g>gt then
        begin
                f[id].g:=gt;
                f[id].v:=i;
                update(id shr 1,i,gt);
        end;
end;

procedure process;
var     i:longint;
        tm:save;
begin
        for i:=1 to n do v[i]:=i;
        qsort(1,n);
        build(1,1,maxt);
        update(la[1],0,0);
        for i:=1 to n do
        begin
                tm:=quece(1,1,maxt,a[i],maxt);
                trace[i]:=tm.v;
                update(la[b[i]],i,tm.g+c[i]);
        end;
        tm:=quece(1,1,maxt,maxt,maxt);
        writeln(go,tm.g);
        i:=tm.v;
        while i<>0 do
        begin
                write(go,v[i],' ');
                i:=trace[i];
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.


