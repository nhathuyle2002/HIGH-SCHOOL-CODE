const
        fi='count3.inp';
        fo='count3.out';
var  n,dem,kq:longint;
s:string;
luu:array[0..1000000] of string;
dd:Array[0..1000000] of boolean;
procedure nhap;
var f:Text;
begin
        assign(f,fi);
        reset(f);
        readln(f,s);
        close(F);
end;
function ch(a:string):string;
begin
        while (length(A)>1) and (a[1]='0') do delete(a,1,1);
        ch:=a;
end;
procedure kt;
var i,j:longint;
c,c1,tam:string;
begin
        while s[1]=' ' do delete(s,1,1);
        while s[length(s)]=' ' do delete(s,length(s),1);
        while (length(s)>1) and (s[1]='0') do delete(s,1,1);
        n:=length(S);
        luu[1]:=s;
        dem:=1;
        for i:=1 to n-1 do
                for j:=1 to n-i+1 do
                        begin
                        tam:=s;
                        inc(dem);
                        delete(tam,j,i);
                        c1:=ch(tam);
                        luu[dem]:=c1;
                        end;
end;
procedure qs(l,r:longint);
var i,j:longint;
t,d:string;
begin
        i:=l; j:=r;
        t:=luu[l+random(r-l+1)];
        repeat
        while luu[i]<t do inc(i);
        while luu[j]>t do dec(j);
        if i<=j then
                begin
                d:=luu[i];
                luu[i]:=luu[j];
                luu[j]:=d;
                inc(i); dec(j);
                end;
        until i>j;
        if i<r  then qs(i,r);
        if l<j then qs(l,j);
end;
function ch3(a:string):boolean;
var i,sum:longint;
begin
        sum:=0;
        for i:=1 to length(A) do
        sum:=sum+ord(a[i])-48;
        if sum mod 3 =0 then exit(True) else exit(False);
end;
procedure main;
var i:longint;
begin
        qs(1,dem);
        fillchar(dd,sizeof(Dd),true);
        kq:=0;
        for i:=1 to dem do if luu[i]=luu[i-1] then dd[i-1]:=false;
        for i:=1 to dem do
                if (dd[i])  then
                if ch3(luu[i]) then inc(kq);
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
kt;
main;
xuat;
end.
