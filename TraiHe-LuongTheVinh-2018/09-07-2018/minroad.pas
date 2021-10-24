const   ginp='minroad.inp';
        gout='minroad.out';
        oo=trunc(1e9)+1;

var     n,tg,tr,res:longint;
        a:array[0..2] of longint;
        d,ms:array[0..1000010] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
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
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        swap(d[i],d[j]);
                        swap(ms[i],ms[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(n,tg,tr);
        for i:=1 to n do readln(d[i],ms[i]);
        sort(1,n);
end;

procedure process;
var     i,j:longint;
begin
        res:=oo;
        j:=1;
        for i:=1 to n do
        begin
                while (j<=n+1) and ((a[1]<tg) or (a[2]<tr)) do
                begin
                        inc(a[ms[j]]);
                        inc(j);
                end;
                if j>n+1 then break;
                res:=min(res,d[j-1]-d[i]);
                dec(a[ms[i]]);
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


