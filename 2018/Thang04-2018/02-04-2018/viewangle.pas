const   ginp='viewangle.inp';
        gout='viewangle.out';

type    mang=record
                x,y:int64;w:real;
                end;

var     gi,go:text;
        n,nn:longint;
        ans:real;
        g:array[0..1000001] of real;
        a:array[0..1000001] of mang;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i].x,a[i].y);
end;

procedure create;
var     i:longint;
        h,c,s:real;
begin
        for i:=1 to n do
        with a[i] do
        begin
                h:=sqrt(x*x+y*y);
                c:=x/h;
                s:=y/h;
                if (c=0) and (s=1) then w:=90 else if (c=0) and (s=-1) then w:=-90 else
                begin
                        w:=arctan(y/x)*180/pi;
                        if c<0 then w:=w+180;
                end;
        end;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        tm:real;
        t:mang;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tm:=a[random(r-l+1)+l].w;
        repeat
                while a[i].w<tm do inc(i);
                while a[j].w>tm do dec(j);
                if i<=j then
                begin
                        t:=a[i];
                        a[i]:=a[j];
                        a[j]:=t;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i:longint;
begin
        a[0].w:=-1000;
        for i:=1 to n do
                if a[i].w<>a[i-1].w then
                begin
                        inc(nn);
                        g[nn]:=a[i].w;
                end;
        if nn=1 then ans:=0
        else
        begin
                ans:=g[nn]-g[1];
                for i:=1 to nn-1 do
                        if ans>360-g[i+1]+g[i] then ans:=360-g[i+1]+g[i];
        end;
end;

procedure output;
begin
        write(go,ans:0:6);
        close(gi);close(go);
end;

begin
        input;
        create;
        sort(1,n);
        process;
        output;
end.









