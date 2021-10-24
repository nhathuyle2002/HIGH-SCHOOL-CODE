const   ginp='minmm.inp';
        gout='minmm.out';
        oo=trunc(1e9);

var     n,k,l,r,res:longint;
        h,d,a:array[0..1000010] of longint;

procedure sort(l,r:longint); inline;
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure enter;
var     i:longint;
begin
        readln(n,k);
        for i:=1 to n do read(a[i]);
        sort(1,n);
end;

procedure pop(i:longint); inline;
begin
        while (l<=r) and (d[l]<=i) do inc(l);
end;

procedure push(i:longint); inline;
begin
        while (l<=r) and (h[i]<=h[d[r]]) do dec(r);
        inc(r);d[r]:=i;
end;

procedure process;
var     i:longint;
begin
        for i:=1 to n-1 do h[i]:=a[i+1]-a[i];
        l:=1;r:=1;d[1]:=0;h[0]:=oo;
        res:=oo;k:=n-k-1;
        for i:=1 to k-1 do push(i);
        for i:=k to n-1 do
        begin
                pop(i-k);push(i);
                res:=min(res,a[i+1]-a[i-k+1]+h[d[l]]);
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
