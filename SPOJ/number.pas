const
        fi='number.inp';
        fo='number.out';
var a,b,kq:int64;
procedure nhap;
var f:Text;
begin
        assign(f,fi);
        reset(F);
        readln(F,a,b);
        close(F);
end;
function pali(a:string):boolean;
var i,n:longint;
begin
        n:=length(a);
        pali:=true;
        for i:=2 to n do if a[i]=a[i-1] then exit(false);
        for i:=length(A) div 2 downto 1 do
        if a[i]=a[n-i+1] then exit(false);
        for i:=2 to n-1 do if a[i-1]=a[i+1] then exit(false);
end;
procedure main;
var i:longint;
a1:string;
begin
        kq:=0;
        for i:=a to b do
                begin
                str(i,a1);
                if pali(a1) then inc(kq);
                end;
end;
procedure xuat;
var f:Text;
begin
        assign(f,fo);
        rewrite(f);
        writeln(F,kq);
        close(F);
end;
begin
nhap;
main;
xuat;
end.
