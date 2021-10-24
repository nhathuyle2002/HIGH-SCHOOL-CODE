const   ginp='ss.inp';
        gout='ss.out';

type    dive=record q,v:longint;end;

var     gi,go:text;
        n,m:longint;
        a:array[0..10001] of dive;
        r:array[0..10001] of longint;
        f:array[0..10001] of int64;
        d:array[-100..100100] of longint;

procedure input;
var     i:longint;
        s:ansistring;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to n do read(gi,r[i]);
        readln(gi);
        read(gi,s);
        for i:=1 to m do d[i]:=ord(s[i])-48;
end;

procedure create;
var     i,tm,co:longint;
        le,ri:array[0..100100] of longint;
begin
        le[0]:=0;
        for i:=1 to m do
                if d[i]=1 then le[i]:=le[i-1] else le[i]:=i;
        ri[m+1]:=m+1;
        for i:=m downto 1 do
                if d[i]=1 then ri[i]:=ri[i+1] else ri[i]:=i;
        for i:=1 to n do
        begin
                tm:=0;co:=0;
                repeat
                        inc(co);
                        tm:=tm+r[i];
                        if d[tm]=1 then tm:=le[tm];
                        if tm>m then break;
                until false;
                a[i].q:=co;
                tm:=m+1;co:=0;
                repeat
                        inc(co);
                        tm:=tm-r[i];
                        if d[tm]=1 then tm:=ri[tm];
                        if tm<=0 then break;
                until false;
                a[i].v:=co;
        end;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        tm,t:dive;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i].q<t.q do inc(i);
                while a[j].q>t.q do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure D_P;
var     i:longint;
begin
        f[1]:=a[1].q;
        f[2]:=a[2].q;
        for i:=3 to n do
                f[i]:=min(f[i-1]+a[1].v+a[i].q,f[i-2]+a[1].v+a[2].v+a[2].q+a[i].q);
end;

procedure output;
begin
        write(go,f[n]);
        close(gi);close(go);
end;

begin
        input;
        create;
        sort(1,n);
        D_P;
        output;
end.









