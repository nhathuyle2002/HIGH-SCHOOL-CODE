const   ginp='ss.inp';
        gout='ss.out';
        maxt=30000;

type    time=record x,y:longint;end;

var     gi,go:text;
        n:longint;
        a:array[0..10001] of time;
        f:array[0..maxt+1] of longint;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:time;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].y<t.y) do inc(i);
                while (a[j].y>t.y) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i].x,a[i].y);
        sort(1,n);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure update(i,x:longint);
begin
        if i>maxt then exit;
        f[i]:=max(f[i],x);
        update(i+i and (-i),x);
end;

function quece(i:longint):longint;
begin
        if i<=0 then exit(0);
        quece:=quece(i-i and (-i));
        quece:=max(quece,f[i]);
end;

procedure process;
var     i,tm:longint;
begin
        fillchar(f,sizeof(f),0);
        for i:=1 to n do
        begin
                tm:=quece(a[i].x);
                update(a[i].y,tm+a[i].y-a[i].x);
        end;
        write(go,quece(maxt));
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
