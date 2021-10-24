const
        fi='chiaruong.inp';
        fo='chiaruong.out';
var n:longint;
max1,nho,dem,sum1,sum2,sum3:int64;
a,x:Array[0..25] of longint;
luu:array[0..10000000] of string[20];
procedure nhap;
var f:Text; i:longint;
begin
        assign(F,fi);
        reset(F);
        readln(F,n);
        for i:=1 to n do
                begin
                read(f,a[i]);
                max1:=max1+a[i];
                end;
        nho:=max1 div 3;
        close(F);
end;
procedure viet;
var i:longint;
s:string;
begin
        s:='';
        inc(Dem);
        for i:=1 to n do
                begin
                if x[i]=1 then s:=s+'A';
                if x[i]=2 then s:=s+'B';
                if x[i]=3 then s:=s+'C';
                end;
        luu[dem]:=s;
end;
procedure dq(i:longint);
var j:longint;
begin
        if (sum1>nho) or (sum2>nho) or (sum3>nho) then exit;
        for j:=1 to 3 do
                begin
                x[i]:=j;
                if j=1 then sum1:=sum1+a[i];
                if j=2 then sum2:=sum2+a[i];
                if j=3 then sum3:=sum3+a[i];
                if (sum1=sum2) and (sum3=sum2) and (i=n) then viet else dq(i+1);
                if j=1 then sum1:=sum1-a[i];
                if j=2 then sum2:=sum2-a[i];
                if j=3 then sum3:=sum3-a[i];
                end;
end;
procedure  xuat;
var g:Text; i:longint;
begin
        assign(g,fo);
        rewrite(g);
        dem:=0;
        dq(1);
        writeln(g,dem);
        for i:=1 to dem do writeln(G,luu[i]);
        close(G);
end;
begin
nhap;
xuat;
end.
