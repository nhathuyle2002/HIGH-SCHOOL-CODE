const   ginp='fm.inp';
        gout='fm.out';

var     gi,go:text;
        n,m,nn:longint;
        a,gt,d:array[0..1000001] of longint;
        ans:int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to n do read(gi,a[i]);
end;

procedure sort(l,r:longint);
var     i,j,tm,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tm:=a[random(r-l+1)+l];
        repeat
                while a[i]<tm do inc(i);
                while a[j]>tm do dec(j);
                if i<=j then
                begin
                        t:=a[i];
                        a[i]:=a[j];
                        a[j]:=t;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function cnp(x:longint):longint;
var     d,c,m:longint;
begin
        if gt[nn]<=x then exit(nn);
        d:=1;c:=nn;
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                if gt[m]>x then c:=m else d:=m;
                m:=(d+c) div 2;
        end;
        for m:=c downto d do
                if gt[m]<=x then exit(m);
        exit(0);
end;

procedure process;
var     i,tm:longint;
begin
        a[0]:=maxlongint;
        for i:=1 to n do
                if a[i]<>a[i-1] then
                begin
                        inc(nn);
                        gt[nn]:=a[i];
                        d[nn]:=1;
                end
                else inc(d[nn]);
        for i:=1 to nn do d[i]:=d[i-1]+d[i];
        for i:=1 to nn do
        begin
                tm:=cnp(m-gt[i]);
                if tm<>0 then ans:=ans+(d[i]-d[i-1])*d[tm];
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        process;
        output;
end.


