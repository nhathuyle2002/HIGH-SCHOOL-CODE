const
        fi='bucket.inp';
        fo='bucket.out';
var n,sum:longint;
kq:int64;
a:Array[0..10000] of longint;
l:array[0..10000000] of byte;
procedure nhap;
var f:text; i:longint;
begin
        assign(f,fi);
        reset(f);
        readln(f,n);
        for i:=1 to n do
                begin
                read(F,a[i]);
                sum:=sum+a[i];
                end;
        close(F);
end;
procedure main;
var i,j:longint;
begin
       l[0]:=1;
       for i:=1 to n do
       for j:=sum downto a[i] do
                if(l[j]=0) and (l[j-a[i]]=1) then l[j]:=1;
       kq:=0;
       for i:=1 to sum do if l[i]=1 then inc(kq);
end;
procedure xuat;
var f:text;
begin
        assign(f,fo);
        rewrite(F);
        writeln(f,kq);
        close(F);
end;
begin
nhap;
main;
xuat;
end.