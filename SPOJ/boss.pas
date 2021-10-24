const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e9);

var     gi,go:text;
        n,st,fst,tv,m:longint;
        a,b,c,d,v,ch,pa,head,y,link,f:array[0..30001] of longint;
        sh:array[100000..999999] of longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort1(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]>t do inc(i);
                while d[j]<t do dec(j);
                if i<=j then
                begin
                        swap(d[i],d[j]);
                        swap(v[i],v[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort1(l,j);sort1(i,r);
end;

procedure sort2(l,r:longint);
var     i,j,t,t2:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=random(r-l+1)+l;
        t2:=b[t];t:=c[t];
        repeat
                while (c[i]>t) or ((c[i]=t) and (b[i]<t2)) do inc(i);
                while (c[j]<t) or ((c[j]=t) and (b[j]>t2)) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        swap(c[i],c[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort2(l,j);sort2(i,r);
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        ch[u]:=0;
        d[u]:=1;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if d[v]=0 then dfs(v);
                ch[u]:=ch[u]+ch[v]+1;
                i:=link[i];
        end;
end;

procedure input;
var     i,cou:longint;
begin
        readln(gi,n,tv);
        for i:=1 to n do
        begin
                readln(gi,a[i],b[i],c[i]);
                d[i]:=b[i];v[i]:=i;
        end;
        sort1(1,n);
        cou:=1;b[v[1]]:=1;
        for i:=2 to n do
        begin
                if d[i]<d[i-1] then inc(cou);
                b[v[i]]:=cou;
        end;
        sort2(1,n);
        for i:=1 to n do sh[a[i]]:=i;
end;

function quece(i:longint):longint;
begin
        if i<=0 then exit(0);
        quece:=quece(i-i and (-i));
        if b[quece]<b[f[i]] then quece:=f[i];
end;

procedure update(i,x:longint);
begin
        if i>n+1 then exit;
        if b[f[i]]<b[x] then f[i]:=x;
        update(i+i and (-i),x);
end;

procedure process;
var     i,tm:longint;
begin
        for i:=1 to n do
        begin
                f[i]:=0;
                link[i]:=0;
                head[i]:=0;
        end;
        m:=0;
        for i:=1 to n do
        begin
                tm:=quece(b[i]-1);
                if tm=0 then pa[i]:=0 else
                begin
                        pa[i]:=tm;
                        inc(m);y[m]:=i;
                        link[m]:=head[tm];
                        head[tm]:=m;
                end;
                update(b[i],i);
        end;
        fillchar(d,sizeof(d),0);
        for i:=1 to n do
                if d[i]=0 then dfs(i);
end;

procedure output;
var     i,nv:longint;
begin
        for i:=1 to tv do
        begin
                readln(gi,nv);
                writeln(go,a[pa[sh[nv]]],' ',ch[sh[nv]]);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        readln(gi,st);
        for fst:=1 to st do
        begin
                input;
                process;
                output;
        end;
        close(gi);close(go);
end.
