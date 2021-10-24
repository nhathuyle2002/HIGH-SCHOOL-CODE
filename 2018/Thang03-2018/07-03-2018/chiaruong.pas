const   ginp='chiaruong.inp';
        gout='chiaruong.out';

var     gi,go:text;
        n,sum,n2,nn,nnn,dem,dem2,xx,yy,zz:longint;
        xuat:array[1..200,1..20] of longint;
        tap:array[0..200] of set of byte;
        a,luu,s,d,s2,luu2,dd:array[0..30] of longint;

procedure input;
var     i:Longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                sum:=sum+a[i];
        end;
end;

procedure check;
var     i:longint;
        tmp:set of byte;
begin
        tmp:=[];
        for i:=1 to nnn do tmp:=tmp+[luu2[i]];
        for i:=1 to dem2 do
                if tmp=tap[i] then exit;
        inc(dem2);
        tap[dem2]:=tmp;
        tmp:=[];
        for i:=1 to n do
                if dd[i]=3 then tmp:=tmp+[i];
        inc(dem2);
        tap[dem2]:=tmp;
        inc(dem);
        for i:=1 to n do
                xuat[dem,i]:=dd[i];
end;

procedure dequy2(i,tt:longint);
var     j:longint;
begin
        for j:=i to n2 do
        begin
                s2[tt]:=s2[tt-1]+a[d[j]];
                luu2[tt]:=d[j];
                dd[luu2[tt]]:=2;
                if s2[tt]=sum then
                begin
                        nnn:=tt;
                        check;
                end
                else if (tt<n2-1) and (s2[tt]<sum) then dequy2(j+1,tt+1);
                dd[luu2[tt]]:=3;
        end;
end;

procedure create;
var     i:longint;
        tmp:set of byte;
begin
        tmp:=[];
        for i:=1 to nn do tmp:=tmp+[luu[i]];
        for i:=1 to dem2 do
                if tmp=tap[i] then exit;
        inc(dem2);
        tap[dem2]:=tmp;
        n2:=0;
        for i:=1 to n do
                if dd[i]=3 then
                begin
                        inc(n2);
                        d[n2]:=i;
                end;
        dequy2(1,1);
end;

procedure dequy1(i,tt:longint);
var     j:longint;
begin
        for j:=i to n do
        begin
                s[tt]:=s[tt-1]+a[j];
                luu[tt]:=i;
                dd[luu[tt]]:=1;
                if s[tt]=sum then
                begin
                        nn:=tt;
                        create;
                end
                else if (tt<n-2) and (s[tt]<sum) then dequy1(j+1,tt+1);
                dd[luu[tt]]:=3;
        end;
end;

procedure process;
var     i:longint;
begin
        if (sum mod 3<>0) or (n<3) then exit;
        for i:=1 to n do dd[i]:=3;
        sum:=sum div 3;
        s[1]:=a[1];
        dd[1]:=1;
        luu[1]:=1;
        dequy1(2,2);
end;

procedure xuatt(i:longint;x,y,z:char);
var     j:longint;
begin
        for j:=1 to n do
                if xuat[i,j]=xx then write(go,x)
                else if xuat[i,j]=yy then write(go,y)
                else write(go,z);
        writeln(go);
end;

procedure output;
var     i,j:longint;
begin
        if dem=0 then write(go,-1) else writeln(go,dem*6);
        for i:=1 to dem do
        begin
                xx:=xuat[i,1];yy:=0;zz:=0;
                j:=2;
                while xuat[i,j]=xx do inc(j);
                yy:=xuat[i,j];
                inc(j);
                while (xuat[i,j]=xx) or (xuat[i,j]=yy) do inc(j);
                zz:=xuat[i,j];
                xuatt(i,'A','B','C');
                xuatt(i,'A','C','B');
                xuatt(i,'B','A','C');
                xuatt(i,'B','C','A');
                xuatt(i,'C','A','B');
                xuatt(i,'C','B','A');
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
