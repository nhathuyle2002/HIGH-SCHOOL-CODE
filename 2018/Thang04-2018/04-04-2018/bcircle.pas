const   ginp='bcircle.inp';
        gout='bcircle.out';

type    mang=record x,y,w:real;end;

var     gi,go:text;
        n:longint;
        x0,y0,a1,b1,c1,a2,b2,c2:real;
        a:array[0..100001] of mang;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i].x,a[i].y);
end;

procedure sort(l,r:longint);
var     i,j,tm1:longint;
begin
        if l>=r then exit;
end;

procedure tdt(x1,y1,x2,y2:real);
var
        a1:=x1-x2;
        b1:=y1-y2;
        c1:=-(x1+x2)/2*a1-(y1+y2)/2*b1;
end;

procedure findtam;
var     tm1,tm2:real;
begin
        tdt(a[1].x,a[1].y,a[2].x,a[2].y);
        a2:=a1;b2:=b1;c2:=c1;
        tdt(a[2].x,a[2].y,a[3].x,a[3].y);
        a1:=a1*b2;b1:=b1*b2;a2:=
end;












