const
        fi='bcircle.inp';
        fo='bcircle.out';
var n:longint;
kq:real;
x,y:Array[0..1000000] of real;
procedure nhap;
var f:Text;
i:longint;
begin
        assign(F,fi);
        reset(f);
        readln(F,n);
        for i:=1 to n do readln(F,x[i],y[i]);
        close(f);
end;
function min(a,b:real):real;
begin
        if a<b then exit(A) else exit(b);
end;
procedure main;
var i,j:longint;
begin
        kq:=maxlongint;
        for i:=1 to n-1 do
        for j:=i+1 to n do
                kq:=min(kq,sqrt(sqr(x[i]-x[j])+sqr(y[i]-y[j])));
end;
procedure xuat;
var f:Text;
begin
        assign(f,fo);
        rewrite(f);
        writeln(F,kq:0:2);
        close(F);
end;
begin
nhap;
main;
xuat;
end.