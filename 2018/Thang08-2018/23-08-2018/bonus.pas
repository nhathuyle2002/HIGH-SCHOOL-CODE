const   ginp='bonus.inp';
        gout='bonus.out';

var     n,res,mg:longint;
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

procedure process;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do read(a[i]);
        sort(1,n);
        mg:=0;res:=0;
        for i:=n downto 1 do
        begin
                if a[i]>mg then inc(res);
                if mg<a[i]-i then mg:=a[i]-i;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
