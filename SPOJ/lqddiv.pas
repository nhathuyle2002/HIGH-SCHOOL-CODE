const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e15);

var     gi,go:text;
        n,m,k,cou:longint;
        res:int64;
        a:array[0..20] of longint;
        b,c,d:array[0..66000] of int64;

procedure dfs(i:longint);
var     j:longint;
        s1,s2:int64;
begin
        if i=k+1 then
        begin
                s1:=0;s2:=0;
                for j:=1 to k do
                        if d[j]=1 then s1:=s1+a[j] else s2:=s2+a[j];
                inc(n);c[n]:=s1-s2;
                exit;
        end;
        for j:=0 to 1 do
        begin
                d[i]:=j;
                dfs(i+1);
        end;
end;

procedure sort(l,r:longint;var q:array of int64);
var     i,j:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=q[random(r-l+1)+l];
        repeat
                while q[i]<t do inc(i);
                while q[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=q[i];q[i]:=q[j];q[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,q);sort(i,r,q);
end;

function abs(x:int64):int64;
begin
        if x<0 then exit(-x) else exit(x);
end;

function cnp(x:int64):longint;
var     l,r,mid:longint;
begin
        l:=1;r:=m;
        while l<>r do
        begin
                mid:=(l+r) shr 1;
                if b[mid]<=x then l:=mid+1 else r:=mid;
        end;
        exit(l);
end;

procedure input;
var     i,tm:longint;
begin
        readln(gi,tm);
        k:=tm div 2;
        for i:=1 to k do read(gi,a[i]);
        dfs(1);
        m:=n;b:=c;
        k:=tm-tm div 2;
        for i:=1 to k do read(gi,a[i]);
        n:=0;dfs(1);
end;

procedure process;
var     i,tm:longint;
        gt:int64;
begin
        res:=oo;
        for i:=1 to m-1 do
        begin
                gt:=abs(b[i]-c[1]);
                if gt=res then inc(cou);
                if gt<res then
                begin
                        res:=gt;
                        cou:=1;
                end;
        end;
        for i:=2 to m do
        begin
                gt:=abs(b[i]-c[n]);
                if gt=res then inc(cou);
                if gt<res then
                begin
                        res:=gt;
                        cou:=1;
                end;
        end;
        sort(1,m,b);
        tm:=0;
        b[0]:=-oo;
        for i:=1 to m do
                if b[i]<>b[i-1] then
                begin
                        inc(tm);
                        b[tm]:=b[i];
                        d[tm]:=1;
                end
                else inc(d[tm]);
        m:=tm;
        for i:=2 to n-1 do
        begin
                tm:=cnp(c[i]);
                gt:=abs(c[i]-b[tm]);
                if gt=res then cou:=cou+d[tm];
                if gt<res then
                begin
                        res:=gt;
                        cou:=d[tm];
                end;
                tm:=tm-1;
                gt:=abs(c[i]-b[tm]);
                if gt=res then cou:=cou+d[tm];
                if gt<res then
                begin
                        res:=gt;
                        cou:=d[tm];
                end;
        end;
        write(go,res,' ',cou div 2);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
