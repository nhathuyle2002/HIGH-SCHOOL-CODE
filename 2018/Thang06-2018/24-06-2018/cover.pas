const   ginp='cover.inp';
        gout='cover.out';
        oo=trunc(1e6);
        maxn=100010;

type    save=record g,v:longint;end;

var     gi,go:text;
        n,dd,cc:longint;
        a,b,la,t,v:array[0..maxn] of longint;
        f:array[0..4*maxn] of save;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint); inline;
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
                        swap(v[i],v[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure input;
var     i,nn:longint;
begin
        readln(gi,n,dd,cc);
        for i:=1 to n do
        begin
                read(gi,a[i],b[i]);
                v[i]:=i;
                a[i]:=a[i]-dd+1;
                b[i]:=b[i]-dd+1;
        end;
        cc:=cc-dd+1;dd:=1;
        sort(1,n);
        nn:=0;
        for i:=1 to n do
        begin
                if a[i]<1 then a[i]:=1;
                if b[i]>1 then
                begin
                        inc(nn);
                        a[nn]:=a[i];b[nn]:=b[i];v[nn]:=v[i];
                end;
        end;
        n:=nn;
end;

procedure build(id,l,r:longint); inline;
var     m:longint;
begin
        f[id].g:=oo;f[id].v:=0;
        if l=r then
        begin
                la[l]:=id;
                exit;
        end;
        m:=(l+r)>>1;
        build(id<<1,l,m);
        build(id<<1+1,m+1,r);
end;

function quece(id,l,r,d,c:longint):save; inline;
var     m:longint;
        tm1,tm2:save;
begin
        if (d>r) or (c<l) then
        begin
                quece.g:=oo;
                exit;
        end;
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r)>>1;
        tm1:=quece(id<<1,l,m,d,c);
        tm2:=quece(id<<1+1,m+1,r,d,c);
        if tm1.g<tm2.g then exit(tm1) else exit(tm2);
end;

procedure update(id:longint;x:save); inline;
begin
        if id<1 then exit;
        if f[id].g>x.g then
        begin
                f[id]:=x;
                update(id>>1,x);
        end;
end;

procedure process;
var     i:longint;
        tm:save;
begin
        build(1,1,maxn);
        tm.g:=0;tm.v:=0;
        update(la[1],tm);
        for i:=1 to n do
        begin
                tm:=quece(1,1,maxn,a[i],b[i]);
                t[i]:=tm.v;tm.v:=i;inc(tm.g);
                update(la[b[i]],tm);
        end;
        tm:=quece(1,1,maxn,cc,maxn);
        if tm.g=oo then write(go,-1) else
        begin
                writeln(go,tm.g);i:=tm.v;
                while i<>0 do
                begin
                        writeln(go,v[i]);
                        i:=t[i];
                end;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.










