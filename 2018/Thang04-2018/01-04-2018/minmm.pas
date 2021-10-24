const   ginp='minmm.inp';
        gout='minmm.out';

var     gi,go:text;
        n,k,l,r,ans:longint;
        a,h,d:array[0..1000001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do read(gi,a[i]);
end;

procedure sort(l,r:longint);
var     i,j,tm,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];
                        a[i]:=a[j];
                        a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function empty:boolean;
begin
        if l>r then exit(false) else exit(true);
end;

procedure push(i:longint);
begin
        while (empty) and (h[i]<=h[d[r]]) do dec(r);
        inc(r);d[r]:=i;
end;

procedure pop(i:longint);
begin
        while (empty) and (d[l]<i) do inc(l);
end;

procedure create;
var     i:longint;
begin
        sort(1,n);
        l:=1;r:=1;h[0]:=maxlongint;
        for i:=2 to n do h[i]:=a[i]-a[i-1];
        for i:=2 to n-k do push(i);
        ans:=a[n-k]-a[1]+h[d[l]];
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,p:longint;
begin
        p:=2;
        for i:=n-k+1 to n do
        begin
                inc(p);pop(p);
                push(i);
                ans:=min(ans,a[i]-a[p-1]+h[d[l]]);
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        create;
        process;
        output;
end.
























