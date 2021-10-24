const
        fi='poison.inp';
        fo='poison.out';
var n:longint;
kq:int64;
a:Array[-1000000..1000000] of longint;
f:array[0..10000,0..10000] of int64;
procedure nhap;
var f:Text; i:longint;
begin
        assign(F,fi);
        reset(F);
        readln(f,n);
        for i:=1 to n do read(F,a[i]);
        close(F);
end;
procedure xuli;
var i,j:longint;
begin
        kq:=maxlongint;
        for i:=1 to n do
        for j:=1 to n do
                begin
                f[i,j]:=sqr(a[i]-a[j])+2*(a[i]+i-a[j]-j)*(i-j);
                if (kq>f[i,j]) and (i<>j) then kq:=f[i,j];
                end;
end;
procedure xuat;
var g:Text;
begin
        assign(g,fo);
        rewrite(g);
        writeln(g,kq);
        close(g);
end;
begin
nhap;
xuli;
xuat;
end.