const   ginp='qq.inp';
        gout='qq.out';
        oo=trunc(1e16);

var     gi,go:text;
        n:longint;
        res:int64;
        xx,yy:array[0..100010] of longint;

procedure swap(var a,b:longint);
var     tm:longint;
begin
        tm:=a;a:=b;b:=tm;
end;

procedure sort(l,r:longint;var a:array of longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,a);sort(i,r,a);
end;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,xx[i],yy[i]);
        sort(1,n,xx);
        sort(1,n,yy);
        res:=oo;
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure main(x,y:array of longint);
var     i:longint;
        sum,kc1,kc2:int64;
        //x,y:array[0..100010] of longint;
begin
        sum:=0;
        for i:=1 to n do x[i]:=x[i]-i+1;
        sort(1,n,x);
        for i:=2 to n do sum:=sum+x[i]-x[1];
        kc1:=sum;
        for i:=2 to n do
        begin
                sum:=sum+(x[i]-x[i-1])*(2*i-n-2);
                kc1:=min(kc1,sum);
        end;
        sum:=0;
        for i:=2 to n do sum:=sum+y[i]-y[1];
        kc2:=sum;
        for i:=2 to n do
        begin
                sum:=sum+(y[i]-y[i-1])*(2*i-n-2);
                kc2:=min(kc2,sum);
        end;
        res:=min(res,kc1+kc2);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        main(xx,yy);main(yy,xx);
        write(go,res);
        close(gi);close(go);
end.
