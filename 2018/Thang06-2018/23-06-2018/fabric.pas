const   ginp='fabric.inp';
        gout='fabric.out';

var     gi,go:text;
        m,n,maxs:longint;
        a,fa:array[0..1211,0..1010] of longint;
        fb,t,d:array[0..1 shl 16-1] of longint;

procedure input;
var     i,j,k:longint;
begin
        readln(gi,m,n,maxs);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
        while m and 15<>0 then
        begin
                inc(m);
                for j:=1 to n do a[m,j]:=1;
        end;
        i:=1;
        while i<=m then
        begin
                for j:=1 to n do
                        for k:=i+1 to i+15 do a[i,j]:=a[i,j]<<1+a[k,j];
                inc(i,16);
        end;
end;

function get(i,x:longint):longint;
begin
        get:=(x>>(i-1)) and 1;
end;

procedure create;
var     i,j,k:longint;
begin
        for j:=1 to n do
        begin
                k:=1;
                while (k*j<maxs) and (k<=n) do inc(k);
                for i:=k to n do
                        fa[i,j]:=fa[i-1,j]+i-k+1;
        end;
        for i:=1 to 1 shl 16-1 do
        begin
                k:=1;
                while get(k,i)=0 do inc(k);
                d[i]:=k;
                k:=16;
                while get(k,i)=0 do dec(k);
                t[i]:=k;
                k:=t[i];
                repeat
                        while (k>d[i]) and (
        end;
end;











