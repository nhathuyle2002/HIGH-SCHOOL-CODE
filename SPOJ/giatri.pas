const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        a:array[0..1000001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure output;
var     i:longint;
begin
        write(go,a[n],' ');
        for i:=n-1 downto 1 do
                if a[i]<>a[i+1] then write(go,a[i]);
        close(gi);close(go);
end;

begin
        input;
        sort(1,n);
        output;
end.