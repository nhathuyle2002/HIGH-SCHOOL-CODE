const
        fi='work.inp';
        fo='work.out';
var n:longint;
kq:int64;
a,b,f:array[0..100009] of int64;
procedure nhap;
var f:text;
i:longint;
begin
        assign(f,fi);
        reset(f);
        readln(F,n);
        for i:=1 to n do readln(F,a[i],b[i]);
        close(f);
end;
procedure trao(var a,b:int64);
var d:longint;
begin
        d:=a; a:=b; b:=d;
end;
procedure qs(l,r:longint);
var i,j,g:longint;
begin
        i:=l;j:=r ;
        g:=l+random(r-l+1);
        repeat
        while (b[i]<b[g]) or ((b[i]=b[g]) and (a[i]<a[g])) do inc(i);
        while (b[j]>b[g]) or ((b[j]=b[g]) and (a[j]>a[g])) do dec(j);
        if i<=j then
                begin
                trao(a[i],a[j]);
                trao(b[i],b[j]);
                inc(i); dec(j);
                end;
        until i>j;
        if i<r then qs(i,r);
        if l<j then qs(l,j);
end;
//unction kt(i,j:longint);
//begin
//        if (a[i]<a[j])
function max(A,b:longint):longint;
begin
        if a>b then exit(a) else exit(b);
end;
procedure main;
var i,j,t:longint;
begin
        qs(1,n);
        for i:=1 to n do
                begin
                t:=b[i]-a[i];
                f[i]:=t;
                for j:=i-1 downto 1 do
                        begin
                        if b[j]>a[i]  then t:=b[j]-a[i] else t:=0;
                        f[i]:=max(f[i],f[j]+b[i]-a[i]-2*t);
                        end;
                if kq<f[i] then kq:=f[i];
                end;
end;
procedure xuat;
var f:Text;
begin
        assign(f,fo);
        rewrite(f);
        writeln(F,kq);
        close(f);
end;
begin
nhap;
main;
xuat;
end.
