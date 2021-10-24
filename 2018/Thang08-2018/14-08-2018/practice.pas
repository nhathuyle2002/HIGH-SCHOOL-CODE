const   ginp='practice.inp';
        gout='practice.out';

var     n:longint;
        c:int64;
        a,b:array[0..100010] of longint;

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
                        tm:=b[i];b[i]:=b[j];b[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure main;
var     i:longint;
begin
        readln(n,c);
        for i:=1 to n do readln(a[i],b[i]);
        sort(1,n);
        for i:=0 to n do
                if c>=a[i+1] then c:=c+b[i+1]
                else break;
        write(i);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
