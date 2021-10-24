const   ginp='l_island.inp';
        gout='l_island.out';
        k=300;oo=1e11;

type    point=record x,y:double;end;

var     n:longint;
        p1,p2:point;
        t,res:double;
        a:array[0..100010] of point;
        d:array[0..100010] of double;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:double;
        tt:point;
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
                        tt:=a[i];a[i]:=a[j];a[j]:=tt;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function kc(x,y:point):double;
begin
        kc:=sqrt(sqr(x.x-y.x)+sqr(x.y-y.y));
end;

function min(x,y:double):double;
begin
        if x<y then exit(x) else exit(y);
end;

procedure main;
var     i,j:longint;
begin
        readln(n,t);
        for i:=1 to n do readln(a[i].x,a[i].y);
        res:=oo;
        for i:=1 to n do d[i]:=kc(a[i],p1);
        sort(1,n);
        for i:=1 to n do
                for j:=i+1 to i+k do
                        if j>n then break else res:=min(res,kc(a[i],a[j]));
        for i:=1 to n do d[i]:=kc(a[i],p2);
        sort(1,n);
        for i:=1 to n do
                for j:=i+1 to i+k do
                        if j>n then break else res:=min(res,kc(a[i],a[j]));
        write(res/t:0:3);
end;

begin
        p1.x:=103;p1.y:=311;
        p2.x:=round(1e6)+13;p2.y:=round(1e6)+7;
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.