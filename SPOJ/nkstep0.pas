const   fi='ss.inp';
        fo='ss.out';
        maxn=100000;
var     t:longint;
        a,l,c:array[1..maxn] of int64;
        x,y,hold,tmp,max,k,w:int64;
        i,j:longint;
        res:int64;
        f:text;
procedure nhap;
begin
    assign(f,fi);
    reset(f);
    readln(f,t);
    max:=-1;
    for i:=1 to t do
        begin
            readln(f,x,y);
            a[i]:=abs(x-y);
            if a[i]>max then max:=a[i];
        end;
    close(f);
end;
procedure xuly;
begin
        l[1]:=1; l[2]:=2;
        c[1]:=1;
        tmp:=1;
        hold:=2;
        w:=2;
        while w<max do
        begin
            inc(tmp);
            c[tmp]:=c[tmp-1]+tmp;
            w:=c[tmp]*2;
            inc(hold);
            l[hold]:=w-tmp;
            inc(hold);
            l[hold]:=w;
        end;
end;
procedure xuat;
begin
    assign(f,fo);
    rewrite(f);
    for i:=1 to t do
        for j:=1 to hold do
        if l[j]>=a[i] then begin writeln(f,j); break; end;
    close(f);
end;
begin
    nhap;
    xuly;
    xuat;
end.
