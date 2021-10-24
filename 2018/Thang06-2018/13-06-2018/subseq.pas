const   ginp='subseq.inp';
        gout='subseq.out';
        maxn=100010;
        oo=trunc(1e9)+100;

type    save=record g,v:longint;end;

var     gi,go:text;
        n,maxk,cou:longint;
        a,b,c,gt,trace:array[0..maxn] of longint;
        g,v,la:array[0..3*maxn] of longint;
        f:array[0..12*maxn] of save;
        tv:save;

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

procedure input;
var     i:longint;
begin
        readln(gi,n,maxk);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                gt[i]:=a[i];
                b[i]:=a[i]-maxk;
                c[i]:=a[i]+maxk;
        end;
        for i:=1 to n do
        begin
                g[i]:=a[i];v[i]:=i;
                g[i+n]:=b[i];v[i+n]:=i+n;
                g[i+n*2]:=c[i];v[i+n*2]:=i+n*2;
        end;
        sort(1,3*n);
        cou:=0;g[0]:=-oo*2;
        for i:=1 to 3*n do
        begin
                if g[i]>g[i-1] then inc(cou);
                if v[i]<=n then a[v[i]]:=cou else
                if v[i]<=2*n then b[v[i]-n]:=cou else
                c[v[i]-2*n]:=cou;
        end;
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

procedure quece(id,l,r,dd,cc:longint);
var     m:longint;
begin
        if (dd>r) or (cc<l) then exit;
        if (dd<=l) and (r<=cc) then
        begin
                if f[id].g>tv.g then tv:=f[id];
                exit;
        end;
        m:=(l+r) shr 1;
        quece(id*2,l,m,dd,cc);
        quece(id*2+1,m+1,r,dd,cc);
end;

procedure update(id:longint);
begin
        if id=0 then exit;
        if f[id].g<tv.g then
        begin
                f[id]:=tv;
                update(id shr 1);
        end;
end;

procedure process;
var     i,dem:longint;
        ou:array[0..maxn] of longint;
begin
        build(1,1,cou);
        for i:=1 to n do
        begin
                tv.g:=0;tv.v:=0;
                quece(1,1,cou,b[i],c[i]);
                trace[i]:=tv.v;
                inc(tv.g);tv.v:=i;
                update(la[a[i]]);
        end;
        writeln(go,f[1].g);
        dem:=0;i:=f[1].v;
        repeat
                inc(dem);ou[dem]:=gt[i];
                i:=trace[i];
        until i=0;
        for i:=dem downto 1 do write(go,ou[i],' ');
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
