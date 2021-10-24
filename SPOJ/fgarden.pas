const
        fi='fgarden.inp';
        fo='fgarden.out';
var n,t,kq,dmi,dma,cmi,cma:longint;
a,s,dmin,dmax:Array[0..3000009] of longint;
procedure nhap;
var f:Text; i:longint;
begin
        assign(f,fi);
        reset(F);
        readln(F,n,t);
        for i:=1 to n do read(F,a[i]);
        close(F);
end;
procedure pop(i:longint);
begin
        while (dmi<cmi) and (dmin[dmi]<=i) do inc(dmi);
        while (dma<cma) and (dmax[dma]<=i) do inc(dma);
end;
procedure push(i:longint);
begin
        while (dmi<>cmi+1) and (a[i]<a[dmin[cmi]]) do dec(cmi);
                while (dma<>cma+1) and (a[i]>a[dmax[cma]]) do dec(cma);
                inc(cma); dmax[cma]:=i;
                inc(cmi); dmin[cmi]:=i;
end;
procedure main;
var i,j:longint;
begin
        kq:=0;
        dmi:=1; dma:=1; cmi:=0; cma:=0;   s[1]:=1;  push(1);
        for i:=2 to n do
                begin
                push(i);
                for j:=s[i-1]to i do
                if a[dmax[dma]]-a[dmin[dmi]]>t then pop(j) else
                        begin
                        s[i]:=j;
                        break;
                        end;
                end;
        for i:=1  to n do
        if kq<i-s[i]+1 then kq:=i-s[i]+1;
end;
procedure xuat;
var f:Text;
begin
        assign(f,fo);
        rewrite(f);
        writeln(f,kq);
        close(F);
end;
begin
nhap;
main;
xuat;
end.
