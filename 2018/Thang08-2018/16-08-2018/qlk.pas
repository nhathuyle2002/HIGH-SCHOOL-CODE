const
        fi='qlk.inp';
        fo='qlk.out';

var
        n,m,dem,maxn:longint;
        a,s:array[0..10000] of longint;
        f:Array[-1000..3000,-1000..3000] of int64;
        kq,kq2:int64;

procedure nhap;
var
        i:longint;
begin
        readln(n,m);
        for i:=1 to m do
        begin
                read(A[i]);
                if maxn<a[i] then maxn:=a[i];
        end;
end;

function check(x:longint):boolean;
var
        i,k:longint;
begin
        k:=0;
        for i:=1 to n do
        k:=k+(a[i] div x);
        if k>=n then exit(True) else exit(false);
end;

function np:longint;
var
        d,c,m:longint;
begin
        d:=0; c:=maxn;
        m:=(d+c) div 2;
        while (D<>m) and (C<>m) do
        begin
                if check(m) then d:=m else c:=m;
                m:=(d+c) div 2;
        end;
        for m:=c downto d do
        begin
                if m=0 then exit(0);
                if check(m) then exit(m);
        end;
end;

function min(A,b:int64):int64;
begin
        if a<B then exit(A) else exit(b);
end;

procedure trao(var a,b:longint);
var
        d:longint;
begin
        d:=a; a:=b; b:=d;
end;

procedure qs(l,r:longint);
var     i,j,d,g:longint;
begin
        i:=l; j:=r;
        d:=a[l+random(r-l+1)];
        repeat
                while a[i]>d do inc(i);
                while a[j]<d do dec(j);
                if i<=j then
                        begin
                        trao(a[i],a[j]);
                        inc(i); dec(j);
                        end;
        until i>j;
        if i<r then qs(i,r);
        if l<j then qs(l,j);
end;

procedure main;
var
        i,j,k,room:longint;
begin
        for i:=1 to m do s[i]:=s[i-1]+a[i];

        kq:=np;
        for i:=0 to m do
        for j:=0 to n do f[i,j]:=maxlongint;

        if kq=0 then exit;
        kq2:=100000000000;

        for i:=1 to m do
        begin
                f[i,1]:=a[i];

                for j:=1 to n do
                begin
                f[i,j]:=f[i-1,j];
                if j<=a[i] div kq then f[i,j]:=min(f[i,j],a[i])
                else
                for k:=1 to a[i] div kq do
                        f[i,j]:=min(F[i,j],f[i-1,j-k]+a[i]);
                end;
        end;

        for i:=1 to m do
        kq2:=min(kq2,f[i,n]);
end;

procedure enter;
begin
        assign(input,fi);    reset(input);
        assign(output,fo);rewrite(output);

        nhap;
        qs(1,m);
        main;
        write(kq,' ',kq2);

        close(input);close(output);
end;

begin
enter;
end.

