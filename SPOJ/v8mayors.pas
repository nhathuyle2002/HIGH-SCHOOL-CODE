const   ginp='ss.inp';
        gout='ss.out';

type    point=record x,y,t:longint;end;

var     gi,go:text;
        n,c0,c1:longint;
        a:array[0..20001] of point;
        e:array[-2001..20001] of point;
        head:array[0..20001] of longint;
        d:array[0..20001] of boolean;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,a[i].x,a[i].y);
                a[i].t:=i;
        end;
end;

procedure sort1(l,r:longint);
var     i,j:longint;
        t,tm:point;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].x<t.x) or ((a[i].x=t.x) and (a[i].y<t.y)) do inc(i);
                while (a[j].x>t.x) or ((a[j].x=t.x) and (a[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure sort2(l,r:longint);
var     i,j:longint;
        t,tm:point;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].y<t.y) or ((a[i].y=t.y) and (a[i].x<t.x)) do inc(i);
                while (a[j].y>t.y) or ((a[j].y=t.y) and (a[j].x>t.x)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i:longint;
begin
        sort1(1,n);

end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
