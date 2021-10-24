const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,nh:longint;
        c,t,a,b,h:array[0..10001] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,c[i],t[i]);
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tm:=a[random(r-l+1)+l];
        repeat
                while a[i]<tm do inc(i);
                while a[j]>tm do dec(j);
                if i<=j then
                begin
                        swap(a[i],a[j]);
                        swap(b[i],b[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure uph(i:longint);
var     j:longint;
begin
        if i<=1 then exit;
        j:=i div 2;
        if h[i]<h[j] then
        begin
                swap(h[i],h[j]);
                uph(j);
        end;
end;

procedure push(x:longint);
begin
        inc(nh);
        h[nh]:=x;
        uph(nh);
end;

procedure downh(i:longint);
var     j:longint;
begin
        j:=i*2;
        if j>nh then exit;
        if (j<nh) and (h[j]>h[j+1]) then inc(j);
        if h[i]>h[j] then
        begin
                swap(h[i],h[j]);
                downh(j);
        end;
end;

function pop:longint;
begin
        pop:=h[1];
        swap(h[1],h[nh]);
        dec(nh);
        downh(1);
end;

function check(tg:longint):boolean;
var     i,j,u:longint;
begin
        for i:=1 to n do
        begin
                a[i]:=c[i]-(tg div t[i]);
                b[i]:=c[i]+(tg div t[i]);
        end;
        sort(1,n);j:=1;
        nh:=0;
        for i:=1 to n do
        begin
                while (a[j]<=i) and (j<=n) do
                begin
                        push(b[j]);
                        inc(j);
                end;
                if nh<=0 then exit(false);
                u:=pop;
                if u<i then exit(false);
        end;
        exit(true);
end;

procedure process;
var     l,r,m:longint;
begin
        l:=0;r:=10000*10000;
        while l<>r do
        begin
                m:=(l+r) div 2;
                if check(m) then r:=m else l:=m+1;
        end;
        write(go,r);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
