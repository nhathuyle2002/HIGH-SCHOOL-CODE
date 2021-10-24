const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,res:longint;
        a,b,d:array[0..100101] of longint;
        f:array[0..1,0..100101] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                a[i]:=a[i]+a[i-1];
        end;
        readln(gi);
        readln(gi,m);
        for i:=1 to m do readln(gi,b[i],d[i]);
end;

function max(x,y:longint):longint;inline;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:longint):longint;inline;
begin
        if x<y then exit(x) else exit(y);
end;

procedure swap(var x,y:longint);inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i]<t do inc(i);
                while b[j]>t do dec(j);
                if i<=j then
                begin
                        swap(b[i],b[j]);
                        swap(d[i],d[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i,r,l,tm,k:longint;
begin
        sort(1,m);
        b[m+1]:=trunc(1e9);
        res:=0;
        for i:=1 to m do
        begin
                k:=i and 1;tm:=res;
                for r:=max(b[i-1]+d[i],b[i]) to min(b[i]+d[i]-1,b[i+1]-1) do
                begin
                        l:=r-d[i];
                        if l<0 then l:=0;
                        if l<b[i-1]+d[i-1] then f[k,r]:=max(f[k,r-1],f[1-k,l]+a[r]-a[l])
                        else f[k,r]:=max(f[k,r-1],tm+a[r]-a[l]);
                end;
                res:=max(res,f[k,r]);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        write(go,res);
        close(gi);close(go);
end.
