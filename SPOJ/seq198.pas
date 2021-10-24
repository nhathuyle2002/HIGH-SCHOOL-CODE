const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,re,nn:longint;
        a,d:array[-10..2001] of longint;
        f:array[0..2001,0..1023] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);nn:=n;
        for i:=1 to n do read(gi,a[i]);
        for i:=-10 to 0 do a[i]:=10*(i-1);
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

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function getbit(k,x:longint):longint;
begin
        getbit:=(x shr (k-1)) and 1;
end;

function setbit(t,k,x:longint):longint;
begin
        if t=1 then setbit:=x or (1 shl (k-1))
        else setbit:=x and (not (1 shl(k-1)));
end;

function check(i,x:longint):boolean;
var     j,k,tm:longint;
begin
        for j:=1 to 9 do
                if getbit(j,x)=1 then
                for k:=j+1 to 10 do
                        if getbit(k,x)=1 then
                        begin
                                tm:=abs(a[i-j+1]-a[i-k+1]);
                                if (tm=1) or (tm=8) or (tm=9) then exit(false);
                        end;
        exit(true);
end;

procedure maximum(i,x:longint);
var     k,j,tm:longint;
begin
        tm:=getbit(1,x);
        j:=x shr 1;
        k:=setbit(1,10,j);
        f[i,x]:=max(f[i-1,j],f[i-1,k])+tm*d[i];
end;

procedure process;
var     i,j,k:longint;
begin
        sort(1,n);
        k:=0;
        for i:=1 to n do
        begin
                if a[i]<>a[i-1] then
                begin
                        inc(k);
                        a[k]:=a[i];
                end;
                inc(d[k]);
        end;
        n:=k;
        for i:=1 to n do
                for j:=0 to 1023 do if check(i,j) then maximum(i,j);
        re:=0;
        for j:=0 to 1023 do
                if re<f[n,j] then re:=f[n,j];
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,nn-re);
        close(gi);close(go);
end.
