const   ginp='weel.inp';
        gout='weel.out';

var     n,k,res,nn:longint;
        a,d:array[0..200010] of longint;

procedure enter;
var     i:longint;
begin
        readln(n,k);
        for i:=1 to n do read(a[i]);
end;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i,i0:longint;
begin
        res:=0;i0:=0;
        for i:=1 to n do
        begin
                if a[i]<0 then dec(k);
                if (a[i]<0) and (a[i-1]>=0) then
                begin
                        inc(res);
                        if i0>0 then
                        begin
                                inc(nn);
                                d[nn]:=i-i0;
                        end;
                end;
                if (a[i]>=0) and (a[i-1]<0) then
                begin
                        inc(res);
                        i0:=i;
                end;
        end;
        sort(1,nn);
        for i:=1 to nn do
                if k-d[i]>=0 then
                begin
                        dec(res,2);
                        dec(k,d[i]);
                end else break;
        if (a[n]>=0) and (k>=n-i0+1) then dec(res);
        if k<0 then write(-1) else write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
