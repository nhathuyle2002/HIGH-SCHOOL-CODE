const   ginp='increasing.inp';
        gout='increasing.out';
        oo=trunc(1e12);

var     n,h,l,r:longint;
        res:int64;
        a,d:array[0..200010] of longint;

procedure enter;
var     i:longint;
begin
        readln(n,h);
        for i:=1 to n do
        begin
                read(a[i]);
                a[i]:=a[i]+n-i;
        end;
end;

procedure pop(i:longint);
begin
        while (l<=r) and (d[l]<=i) do inc(l);
end;

procedure push(i:longint);
begin
        while (l<=r) and (a[d[r]]<=a[i]) do dec(r);
        inc(r);d[r]:=i;
end;

procedure process;
var     i:longint;
        sum,tm:int64;
begin
        l:=1;r:=1;
        res:=oo;
        sum:=0;
        for i:=1 to h-1 do
        begin
                sum:=sum+a[i];
                push(i);
        end;
        for i:=h to n do
        begin
                pop(i-h);push(i);
                sum:=sum-a[i-h]+a[i];
                tm:=int64(h)*(n+h-i)-sum;
                if (a[d[l]]<=n+h-i) and (tm<res) then res:=tm;
        end;
        if res=oo then write(-1) else write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.