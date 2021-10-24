const   ginp='running.inp';
        gout='running.out';

var     n:longint;
        res:int64;
        a:array[0..10010] of longint;

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
var     i,j1,j2,k:longint;
begin
        res:=0;
        for i:=1 to n-2 do
        begin
                j1:=i+2;j2:=i+2;
                for k:=i+1 to n-1 do
                begin
                        while (j1<=n) and (a[j1]-a[k]<a[k]-a[i]) do inc(j1);
                        while (j2<=n) and (a[j2]-a[k]<=(a[k]-a[i])*2) do inc(j2);
                        res:=res+j2-j1;
                end;
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
