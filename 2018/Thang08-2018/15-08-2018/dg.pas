const   ginp='dg.inp';
        gout='dg.out';

var     n:longint;
        res:int64;
        a,b:array[0..2000010] of longint;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=random(r-l+1)+l;
        t:=a[t]-b[t];
        repeat
                while a[i]-b[i]<t do inc(i);
                while a[j]-b[j]>t do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i:longint;
begin
        readln(n);
        for i:=1 to 2*n do readln(a[i],b[i]);
        sort(1,2*n);
        res:=0;
        for i:=1 to n do res:=res+b[i];
        for i:=n+1 to 2*n do res:=res+a[i];
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
