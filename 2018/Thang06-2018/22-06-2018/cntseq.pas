const   ginp='cntseq.inp';
        gout='cntseq.out';
        maxn=1000100;

var     gi,go:text;
        m,n,cou,r:longint;
        a,vl,vr,q:array[0..maxn] of longint;
        f:array[0..3*maxn] of int64;
        d,v:array[0..3*maxn] of longint;

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
                        swap(d[i],d[j]);
                        swap(v[i],v[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,d[i]);
                v[i]:=i;
        end;
        readln(gi,m);
        for i:=1 to m do
        begin
                readln(gi,d[i+n],d[i+n+m]);
                dec(d[i+n]);
                v[i+n]:=i+n;v[i+n+m]:=i+n+m;
        end;
        sort(1,n+2*m);
        cou:=1;
        for i:=1 to n+2*m do
        begin
                if d[i]>d[i-1] then inc(cou);
                if v[i]<=n then a[v[i]]:=cou else
                if v[i]<=n+m then vl[v[i]-n]:=cou else
                vr[v[i]-n-m]:=cou;
        end;
end;

procedure update(i:longint;x:int64);
begin
        if i>cou then exit;
        f[i]:=f[i]+x;
        update(i+i and (-i),x);
end;

function quece(i:longint):int64;
begin
        if i<1 then exit(0);
        quece:=f[i]+quece(i-i and (-i));
end;

procedure main;
var     i:longint;
begin
        fillchar(f,sizeof(f),0);
        r:=0;q[0]:=0;
        for i:=1 to n do
        begin
                while (r>0) and (a[i]>=a[q[r]]) do
                begin
                        update(a[q[r]],(q[r]-q[r-1])*int64(i-q[r]));
                        dec(r);
                end;
                inc(r);q[r]:=i;
        end;
        for i:=1 to r do
                update(a[q[i]],(q[i]-q[i-1])*int64(n-q[i]+1));
        for i:=1 to m do
                writeln(go,quece(vr[i])-quece(vl[i]));
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        main;
        close(gi);close(go);
end.










