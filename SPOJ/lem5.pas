const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,n0:longint;
        a,b,gt,vt,v:array[0..100001] of longint;
        f:array[0..100001,0..101] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,a[i]);
                vt[i]:=i;
        end;
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i]<t do inc(i);
                while b[j]>t do dec(j);
                if i<=j then
                begin
                        swap(b[i],b[j]);swap(vt[i],vt[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure create;
var     i:longint;
begin
        b:=a;sort(1,n);
        n0:=0;gt[0]:=-1000000101;
        for i:=1 to n do
        begin
                if b[i]<>b[i-1] then
                begin
                        inc(n0);
                        gt[n0]:=b[i];
                end;
                v[vt[i]]:=n0;
        end;
end;

procedure process;
var     i,j,tm:longint;
begin
        for i:=1 to n do
        begin
                j:=v[i]-1;
                while a[i]-gt[j]<=100 do
                begin
                        tm:=a[i]-gt[j];
                        f[v[i],tm]:=f[j,tm]+1;
                        dec(j);
                end;
                for j:=1 to 100 do
                        if f[v[i],j]=0 then f[v[i],j]:=1;
        end;
end;

procedure output;
var     i,j,ans:longint;
begin
        ans:=0;
        for i:=1 to n0 do
                for j:=1 to 100 do
                        if f[i,j]>ans then ans:=f[i,j];
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        create;
        process;
        output;
end.
