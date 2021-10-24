const   ginp='average.inp';
        gout='average.out';

var     n:longint;
        res:int64;
        v,f:array[0..1000010] of longint;
        a:array[0..1000010] of int64;

procedure sort(l,r:longint); inline;
var     i,j,tt,t2:longint;
        t1,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t1:=random(r-l+1)+l;
        t2:=v[t1];t1:=a[t1];
        repeat
                while (a[i]<t1) or ((a[i]=t1) and (v[i]<t2)) do inc(i);
                while (a[j]>t1) or ((a[j]=t1) and (v[j]>t2)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        tt:=v[i];v[i]:=v[j];v[j]:=tt;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i,p:longint;
begin
        readln(n);
        for i:=1 to n do read(a[i]);
        readln;read(p);
        for i:=1 to n do
        begin
                a[i]:=a[i-1]+a[i]-p;
                v[i]:=i;
        end;
        sort(1,n);
end;

procedure update(i:longint); inline;
begin
        if i>n then exit;
        inc(f[i]);
        update(i+i and (-i));
end;

function quece(i:longint):longint; inline;
begin
        if i<1 then exit(0);
        quece:=f[i]+quece(i-i and (-i));
end;

procedure process;
var     i:longint;
begin
        res:=0;
        for i:=1 to n do
        begin
                if a[i]>=0 then inc(res);
                res:=res+quece(v[i]-1);
                update(v[i]);
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
