const   ginp='qq.inp';
        gout='qq.out';

var     n:longint;
        x,y:array[0..100010] of longint;
        res:int64;

procedure sort(l,r:longint;var d:array of longint);
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
        sort(l,j,d);sort(i,r,d);
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

function kc1(a:array of longint):int64;
var     i:longint;
        sum:int64;
begin
        sort(1,n,a);
        for i:=1 to n do a[i]:=a[i]-i;
        sort(1,n,a);
        sum:=0;
        for i:=2 to n do sum:=sum+a[i]-a[1];
        kc1:=sum;
        for i:=2 to n do
        begin
                sum:=sum+int64(2*i-n-2)*(a[i]-a[i-1]);
                kc1:=min(kc1,sum);
        end;
end;

function kc2(b:array of longint):int64;
var     i:longint;
        sum:int64;
begin
        sort(1,n,b);
        sum:=0;
        for i:=2 to n do sum:=sum+b[i]-b[1];
        kc2:=sum;
        for i:=2 to n do
        begin
                sum:=sum+int64(2*i-n-2)*(b[i]-b[i-1]);
                kc2:=min(kc2,sum);
        end;
end;

procedure main;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do readln(x[i],y[i]);
        res:=min(kc1(x)+kc2(y),kc1(y)+kc2(x));
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
