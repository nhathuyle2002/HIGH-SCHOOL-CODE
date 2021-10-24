const
        fi='bom.inp';
        fo='bom.out';
var n,s:longint;
kq,kq1:int64;
a:Array[0..1009 ] of longint;
f,sl:Array[0..1000,0..50000] of int64;
procedure nhap;
var f:Text;
i:longint;
begin
        assign(F,fi);
        reset(F);
        readln(F,n,s);
        for i:=1 to n do read(F,a[i]);
        close(F);
end;
function max(a,b:int64):int64;
begin
        if a>b then max:=A else max:=B;
end;
procedure qhd;
var i,j:longint;
begin
        sl[0,0]:=1;
        for i:=1 to n do sl[i,0]:=1;
        for i:=1 to s do sl[0,i]:=1;
        for i:=1 to n do
        for j:=1 to s do
                begin
                if a[i]<=j then
                        begin
                        if f[i-1,j-a[i]]+a[i]>f[i-1,j] then
                                begin
                                f[i,j]:=f[i-1,j-a[i]]+a[i];
                                sl[i,j]:=sl[i-1,j-a[i]];
                                end
                        else
                                begin
                                f[i,j]:=f[i-1,j];
                                sl[i,j]:=sl[i-1,j];
                                end;
                        if f[i-1,j-a[i]]+a[i]=f[i-1,j] then
                                begin
                                f[i,j]:=f[i-1,j];
                                sl[i,j]:=sl[i-1,j]+sl[i-1,j-a[i]];
                                end;
                        end
                else
                        begin
                        f[i,j]:=f[i-1,j];
                        sl[i,j]:=sl[i-1,j];
                        end;
                if kq<f[i,j] then kq:=f[i,j];
                end;
end;
procedure xuat;
var f:Text;
begin
        assign(F,fo);
        rewrite(F);
        kq:=0; kq1:=0;
        qhd;
        writeln(F,kq);
        if kq<>0 then writeln(F,sl[n,s]);
        close(F);
end;
begin
nhap;
xuat;
end.
