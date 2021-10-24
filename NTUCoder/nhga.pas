const   ginp='ss.inp';
        gout='ss.out';

var     n,res:longint;
        a:array[0..100010] of longint;

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

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do read(a[i]);
        sort(1,n);
end;

procedure process;
var     i:longint;
begin
        res:=maxlongint;
        for i:=2 to n do
                if a[i]-a[i-1]<res then res:=a[i]-a[i-1];
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
