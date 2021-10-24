const
        fi='cprime.inp';
        fo='cprime.out';
        maxn=1000000;
var t,demnt,demkq:longint;
kq:extended;
dd:array[0..maxn+10] of boolean;
luu:Array[0..maxn] of int64;
luu2:Array[0..maxn] of extended;
procedure sang;
var i,j:longint;
begin
        fillchar(dd,sizeof(dd),true);
        dd[1]:=false; dd[0]:=false;
        for i:=2 to trunc(sqrt(maxn)) do
                begin
                if dd[i] then
                        begin
                        j:=i*i;
                        while j<=maxn do
                                begin
                                dd[j]:=false;
                                j:=j+i;
                                end;
                        end;
                end;
        demnt:=0;
        for i:=1 to maxn do
        if dd[i] then
                begin
                inc(demnt);
                luu[demnt]:=i;
                end;
end;
procedure kt;
var i,j,k:longint;
t:extended;
begin
        demkq:=0;
        for i:=1 to demnt do
                begin
                inc(demkq);
                luu2[demkq]:=luu[i];
                for j:=2 to demnt do
                        begin
                        t:=luu[i];
                        t:=exp((luu[j]-1)*ln(luu[i]));
                        if t>1000000000000 then break;
                        inc(demkq);
                        luu2[demkq]:=t;
                        end;
                end;
end;
procedure qs(l,r:longint);
var i,j:longint;
x,t:extended;
begin
        i:=l; j:=r;
        x:=luu2[l+random(r-l+1)];
        repeat
        while luu2[i]<x do inc(i);
        while luu2[j]>x do dec(j);
        if i<=j then
                begin
                t:=luu2[i];
                luu2[i]:=luu2[j];
                luu2[j]:=t;
                inc(i); dec(j);
                end;
        until i>j;
        if i<r then qs(i,r);
        if l<j then qs(l,j);
end;
function npd(g:int64):longint;
var d,c,x:longint;
begin
        d:=1; c:=demkq;
        while d<c do
                begin
                x:=(d+c) div 2;
                if g<=round(luu2[x]) then c:=x else d:=x+1;
                end;
        if round(luu2[d])<=g then exit(d)  else exit(d-1);
end;
function npt(g:int64):longint;
var d,c,x:longint;
begin
        d:=1; c:=demkq;
        while d<c do
                begin
                x:=(d+c) div 2;
                if round(luu2[x])>=g then c:=x else d:=x+1;
                end;
        if round(luu2[d])>=g then exit(d) else exit(d+1);
end;
procedure xuli(a,b:int64);
var i,j,k:longint;
b1,a1:int64;
begin
        a1:=npt(a);
        b1:=npd(b);
        kq:=b1-a1+1;
end;
procedure nhap;
var f,g:Text; i:longint;
a,b:int64;
begin
        assign(f,fi); assign(g,fo);
        reset(F); rewrite(g);
        readln(F,t);
        for i:=1 to t do
                begin
                kq:=0;
                readln(f,a,b);
                xuli(a,b);
                writeln(g,kq:0:0);
                end;
        close(F); close(G);
end;
begin
sang;
kt;
qs(1,demkq);
nhap;
end.





