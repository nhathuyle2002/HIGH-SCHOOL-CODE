const   ginp='rline.inp';
        gout='rline.out';

var     gi,go:text;
        n,res:longint;
        a,b,f:array[0..300010] of longint;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint); inline;
var     i,j,t1,t2:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t1:=random(r-l+1)+l;
        t2:=b[t1];t1:=a[t1];
        repeat
                while (a[i]<t1) or ((a[i]=t1) and (b[i]<t2)) do inc(i);
                while (a[j]>t1) or ((a[j]=t1) and (b[j]>t2)) do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function max(x,y:longint):longint; inline;
begin
        if x>y then exit(x) else exit(y);
end;

function cnp(x:longint):longint; inline;
var     d,c,m:longint;
begin
        d:=1;c:=n+1;
        while d<c do
        begin
                m:=(d+c) shr 1;
                if a[m]<=x then d:=m+1 else c:=m;
        end;
        cnp:=d-1;
end;

procedure main;
var     i,maxb,v,sum,mb,tmp:longint;
begin
        readln(n);
        maxb:=0;
        for i:=1 to n do
        begin
                readln(a[i],b[i]);
                maxb:=max(maxb,b[i]);
        end;
        sort(1,n);
        f[n]:=maxb-b[n];
        for i:=n-1 downto 2 do
        begin
                v:=cnp(b[i]);
                if b[i]<=a[i+1] then f[i]:=f[i+1]+a[i+1]-b[i]
                else if b[i]<=b[v] then f[i]:=f[v]
                else f[i]:=f[v]-b[i]+b[v];
        end;
        maxb:=maxb-a[1];
        res:=maxb-f[2]-a[2]+a[1];
        sum:=0;mb:=b[1];
        for i:=2 to n-1 do
        begin
                v:=cnp(mb);
                if mb<=a[i+1] then tmp:=maxb-sum-f[i+1]-a[i+1]+mb
                else if mb<=b[v] then tmp:=maxb-sum-f[v]
                else tmp:=maxb-sum-f[v]+mb-b[v];
                res:=max(res,tmp);
                if a[i]>mb then sum:=sum+a[i]-mb;
                mb:=max(mb,b[i]);
        end;
        res:=max(res,-sum-a[1]+mb);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
