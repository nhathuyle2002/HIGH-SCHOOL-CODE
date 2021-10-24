const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,p,ans:longint;
        sum,vt,mvt,a:array[0..50010] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,p);
        for i:=1 to n do readln(gi,a[i]);
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
        t:=sum[random(r-l+1)+l];
        repeat
                while sum[i]<t do inc(i);
                while sum[j]>t do dec(j);
                if i<=j then
                begin
                        swap(sum[i],sum[j]);
                        swap(vt[i],vt[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function cnp(x:longint):longint;
var     d,c,m:longint;
begin
        d:=1;c:=n+1;
        while d<>c do
        begin
                m:=(d+c) div 2;
                if sum[m]<=x then d:=m+1 else c:=m;
        end;
        exit(mvt[d-1]);
end;

procedure process;
var     i,tmp,tm:longint;
begin
        for i:=1 to n do
        begin
                sum[i]:=sum[i-1]+a[i];
                vt[i]:=i;
        end;
        sum[n+1]:=maxlongint;
        sort(1,n);
        mvt[1]:=vt[1];
        for i:=2 to n do
                if mvt[i-1]<vt[i] then mvt[i]:=mvt[i-1] else mvt[i]:=vt[i];
        tmp:=0;ans:=0;
        for i:=1 to n do
        begin
                tmp:=tmp+a[i];
                if tmp>=p then ans:=i else
                if tmp-sum[1]>=p then
                begin
                        tm:=cnp(tmp-p);
                        if (tm<i) and (i-tm>ans) then ans:=i-tm;
                end;
        end;
end;

procedure output;
begin
        if ans=0 then write(go,-1) else write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
