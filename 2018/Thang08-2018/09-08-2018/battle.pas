const   ginp='battle.inp';
        gout='battle.out';
        base=round(1e9)+9;

var     m,n,maxk:longint;
        res:int64;
        a,b:array[0..1010] of int64;
        f:array[0..11,0..1010,0..1010] of int64;
        sum:array[0..1010,0..1010] of int64;

procedure sort(l,r:longint;var c:array of int64);
var     i,j:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=c[random(r-l+1)+l];
        repeat
                while c[i]<t do inc(i);
                while c[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=c[i];c[i]:=c[j];c[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>=j;
        sort(l,j,c);sort(i,r,c);
end;

procedure enter;
var     i:longint;
begin
        readln(m,n,maxk);
        for i:=1 to m do read(a[i]);readln;
        for i:=1 to n do read(b[i]);
        sort(1,m,a);sort(1,n,b);
end;

procedure process;
var     i,j,k:longint;
begin
        for i:=1 to m do
                for j:=1 to n do
                        if a[i]>b[j] then f[1,i,j]:=1 else f[1,i,j]:=0;
        for k:=2 to maxk do
                for i:=1 to m do
                        for j:=1 to n do
                        begin
                                sum[i,j]:=(sum[i-1,j]+sum[i,j-1]-sum[i-1,j-1]+f[k-1,i,j]+base) mod base;
                                if a[i]>b[j] then f[k,i,j]:=sum[i-1,j-1] else f[k,i,j]:=0;
                        end;
        res:=0;
        for i:=1 to m do
                for j:=1 to n do
                        res:=(res+f[maxk,i,j]) mod base;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
