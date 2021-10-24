const
        fi='paint.inp';
        fo='paint.out';
var t,n,i:longint;
sum,kq:int64;
x:array[-5..30] of longint;
a:Array[-5..5,-5..30] of longint;
f:array[-5..30,-5..5] of int64;
function min(a,b:int64):int64;
begin
        if a<b then exit(a) else exit(B);
end;
function max(A,b:int64):int64;
begin
        if a>b then exit(A) else exit(B);
end;
procedure dq;
var i,j,k:longint;
begin
        for i:=1 to n do
        for j:=1 to 3 do f[i,j]:=maxlongint;
        for i:=1 to 3 do f[1,i]:=a[i,1];
        for i:=2 to n do
                begin
                for j:=1 to 3 do
                        begin
                        for k:=1 to 3 do
                                begin
                                if k<>j then f[i,j]:=min(f[i,j],f[i-1,k]+a[j,i]);
                                end;
                        end;
                end;
end;
procedure nhap;
var h:Text; g:text;
j,k:longint;
begin
        assign(h,fi);
        reset(h); assign(g,fo);
        rewrite(g);
        readln(h,t);
        for j:=1 to t do
                begin
                readln(h,n);
                kq:=maxlongint;
                for k:=1 to n do readln(h,a[1,k],a[2,k],a[3,k]);
                dq;
                for i:=1 to 3 do if kq>f[n,i] then kq:=f[n,i];
                writeln(g,kq);
                end;
        close(h);
        close(G);
end;
begin
nhap;
end.

