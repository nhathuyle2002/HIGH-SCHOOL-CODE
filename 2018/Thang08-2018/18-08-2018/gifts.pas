const   ginp='gifts.inp';
        gout='gifts.out';
        oo=trunc(1e9)+1;

var     n,mg,res:longint;
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

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        readln(n,mg);
        for i:=1 to n do read(a[i]);
        sort(1,n);
        res:=0;j:=n;
        for i:=1 to n-1 do
        begin
                while (i<j) and (a[i]+a[j]>mg) do dec(j);
                if i=j then break else res:=max(res,a[i]+a[j]);
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
