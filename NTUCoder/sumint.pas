const   ginp='ss.inp';
        gout='ss.out';

var     x:int64;
        n,res:longint;
        a:array[0..20] of int64;
        d:array[0..20] of longint;
        u,v:array[0..100010] of int64;

procedure enter;
var     i:longint;
        xx:int64;
begin
        xx:=x;
        while xx mod 2=0 do xx:=xx div 2;
        for i:=3 to 1000000 do
                if i>sqrt(xx) then break else
                if xx mod i=0 then
                begin
                        inc(n);a[n]:=i;
                        while xx mod i=0 do
                        begin
                                inc(d[n]);
                                xx:=xx div i;
                        end;
                end;
        if xx>1 then
        begin
                inc(n);
                a[n]:=xx;d[n]:=1;
        end;
end;

procedure kq(a,b:int64);
var     l,r:int64;
begin
        l:=(a-b) div 2;
        r:=(a+b) div 2;
        if (l>0) and (l<r) then
        begin
                inc(res);
                u[res]:=l;v[res]:=r;
        end;
end;

procedure try(i:longint;t:int64);
var     j:longint;
        l,r:int64;
begin
        if i>n then
        begin
                kq(2*x div t,t-1);
                kq(t,2*x div t-1);
                exit;
        end;
        for j:=0 to d[i] do
        begin
                try(i+1,t);
                t:=t*a[i];
        end;
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=u[random(r-l+1)+l];
        repeat
                while u[i]>t do inc(i);
                while u[j]<t do dec(j);
                if i<=j then
                begin
                        tm:=u[i];u[i]:=u[j];u[j]:=tm;
                        tm:=v[i];v[i]:=v[j];v[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i:longint;
begin
        try(1,1);
        writeln(res);
        sort(1,res);
        for i:=1 to res do writeln(u[i],' ',v[i]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        read(x);
        if x=0 then write(0) else
        begin
                enter;
                process;
        end;
        close(input);close(output);
end.
