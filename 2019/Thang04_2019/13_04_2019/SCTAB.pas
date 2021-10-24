const   fi='SCTAB.INP';
        fo='SCTAB.OUT';
var     n,m,s,gh:longint;
        cs:array[0..20,0..200] of longint;
        b:Array[0..100] of longint;
        a:array[1..20,1..10] of integer;
        dd:array[1..20] of boolean;
procedure       sort(cot,j:longint);
var     i,u,v,tmp:longint;
begin
        for i:=1 to n do
                cs[i,j]:=cs[i,j-1];
        for u:=1 to n do
        for v:=n-1 downto u do
        if a[cs[v,j],cot]>a[cs[v+1,j],cot] then
        begin
                tmp:=cs[v,j];
                cs[v,j]:=cs[v+1,j];
                cs[v+1,j]:=tmp;
        end;
end;
procedure       nhap;
var     f:text;
        i,j:longint;
begin
        assign(f,fi); reset(f);
        readln(f,n,m,s);
        for i:=1 to n do
        begin
                cs[i,0]:=i;
                for j:=1 to m do
                        read(f,a[i,j]);
                readln(f);
        end;
        for i:=1 to s do
        begin
                read(f,j);
                sort(j,i);
        end;
        for i:=1 to n do
                cs[i,200]:=cs[i,s];
        close(f);
end;
procedure       xuat(j:longint);
var     g:text;
        i:longint;
begin
        assign(g,fo); rewrite(G);
        writeln(g,j);
        for i:=1 to j do
                write(g,b[i],' ');
      //  writeln(g); for i:=1 to n do writeln(g,cs[i,j],' ',cs[i,200]);
        close(g);
        HALT;
end;
procedure       kiemtra(j:longint);
var     i:longint;
begin
        for i:=1 to n do
                if cs[i,j]<>cs[i,200] then exit;
        xuat(j);
end;
procedure       try(i:longint);
var     j:longint;
begin
        for j:=1 to m do
        if dd[j] then
        begin
                dd[j]:=false;
                b[i]:=j;
                sort(j,i);
                if i<gh then
                        try(i+1)
                else    kiemtrA(i);
                dd[j]:=true;
        end;
end;
procedure       xuli;
var     i,j:longint;
begin
        for i:=1 to m do
                dd[i]:=true;
        kiemtra(0);
        for gh:=1 to m do
                try(1);
end;
begin
        nhap;
        xuli;
end.
