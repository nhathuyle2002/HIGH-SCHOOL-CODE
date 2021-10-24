Const
        tfi='ss.inp';
        tfo='ss.out';
        maxn=500;

Type
        arr1    =array[1..maxn,1..maxn] of longint;
        arr2    =array[0..maxn,0..maxn] of qword;
        arr3    =array[0..maxn,0..maxn] of boolean;

Var
        n       :longint;
        k       :longint;
        a       :arr1;
        s       :arr2;
        L       :arr3;
        fi,fo   :text;

Procedure nhap;
var
        i,j     :longint;
begin
        readln(fi,n);
        for i:=1 to n do
                for j:=1 to n do
                        read(fi,a[i,j]);
end;

Procedure Init;
var
        i,j     :longint;
begin
        for i:=0 to n do
                begin
                        s[0,i]:=0;
                        s[i,0]:=0;
                end;
        for i:=1 to n do
                for j:=1 to n do
                        s[i,j]:=s[i-1,j]+s[i,j-1]+a[i,j]-s[i-1,j-1];
        for i:=1 to n do
                begin
                        if s[i,1] mod 2=0 then L[i,1]:=true
                                else L[i,1]:=false;
                        if s[1,i] mod 2=0 then L[1,i]:=true
                                else L[1,i]:=false;
                end;
end;

Procedure solution;
var
        i,j     :longint;
        x,y     :boolean;
        h,c     :qword;
begin
        for i:=2 to n do
                for j:=2 to n do
                        begin
                                h:=s[i,j]-s[i-1,j];
                                c:=s[i,j]-s[i,j-1];
                                if (h mod 2=0) and (L[i-1,j]=false) then x:=true
                                        else x:=false;
                                if (c mod 2=0) and (L[i,j-1]=false) then y:=true
                                        else y:=false;
                                L[i,j]:=x or y;
                        end;
end;

Procedure xuat;
begin
        if L[n,n]=true then writeln(fo,'YES')
                else writeln(fo,'NO');
end;

Procedure Process;
var
        i       :longint;
begin
        assign(fi,tfi);
        reset(fi);
        assign(fo,tfo);
        rewrite(fo);
        readln(fi,k);
        for i:=1 to k do
                begin
                        nhap;
                        Init;
                        solution;
                        xuat;
                end;
        close(fi);
        close(fo);
end;

begin
        Process;
end.
