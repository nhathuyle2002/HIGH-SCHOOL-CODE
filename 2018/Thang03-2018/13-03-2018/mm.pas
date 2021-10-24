const   ginp='mwand.inp';
        gout='mwand.out';
        kk=1000000007;

var     gi,go:text;
        n,nn:longint;
        dem:int64;
        a,b,cs:array[0..100001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        readln(gi,nn);
        for i:=1 to nn do read(gi,b[i]);
end;

procedure sort(l,r:longint);
var     i,j,tmp1,x:longint;
        tmp2:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        x:=random(r-l+1)+l;
        repeat
                while (a[x]>a[i]) or ((a[x]=a[i]) and (cs[i]<cs[x])) do inc(i);
                while (a[x]<a[j]) or ((a[x]=a[j]) and (cs[j]>cs[x])) do dec(j);
                if i<=j then
                begin
                        tmp1:=cs[i];
                        cs[i]:=cs[j];
                        cs[j]:=tmp1;
                        tmp2:=a[i];
                        a[i]:=a[j];
                        a[j]:=tmp2;
                        inc(i);
                        dec(j);
                end;
        until i>j;
        if l<j then sort(l,j);
        if i<r then sort(i,r);
end;

function cnp2(x:int64):longint;
var     m,d,c:longint;
begin
        d:=1;c:=n;
        if d>c then exit(0);
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                if x<a[m] then c:=m else d:=m;
                m:=(d+c) div 2;
        end;
        for m:=c downto d do
                if a[m]=x then exit(m);
        exit(0);
end;

function cnp1(x:int64):longint;
var     m,d,c:longint;
begin
        d:=1;c:=n;
        if d>c then exit(0);
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                if x>a[m] then d:=m else c:=m;
                m:=(d+c) div 2;
        end;
        for m:=d to c do
                if a[m]=x then exit(m);
        exit(0);
end;

function cnp3(d,c,vt:longint):longint;
var     m:longint;
begin
        if d>c then exit(0);
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                if cs[m]>=vt then c:=m else d:=m;
                m:=(d+c) div 2;
        end;
        for m:=c downto d do
                if cs[m]<vt then exit(m);
end;

function cnp4(d,c,vt:longint):longint;
var     m:longint;
begin
        if (d>c) then exit(0);
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                if cs[m]>vt then c:=m else d:=m;
                m:=(d+c) div 2;
        end;
        for m:=d to c do
                if cs[m]>vt then exit(m);
end;

procedure process;
var     i,tmp1,tmp2,j,tmp3,tmp4,tmp5,tmp6:longint;
begin
        for i:=1 to n-1 do
                if a[i] mod 3=0 then
                begin
                        tmp1:=cnp1(3*a[i]);
                        tmp2:=cnp2(3*a[i]);
                        tmp3:=cnp1(a[i] div 3);
                        tmp4:=cnp2(a[i] div 3);
                        if (tmp1<>0) and (tmp2<>0) and (tmp3<>0) and (tmp4<>0) and (cs[tmp3]<cs[i]) and (cs[tmp2]>cs[i]) then
                        begin
                                tmp5:=cnp4(tmp1,tmp2,i);
                                tmp6:=cnp3(tmp3,tmp4,i);
                                dem:=(dem+(tmp2-tmp5+1)*(tmp6-tmp3+1)) mod kk;
                        end;
                end;
end;

procedure propro;
var     i:longint;
begin
        n:=0;
        for i:=1 to nn do
                if b[i]>=0 then
                begin
                        inc(n);
                        a[n]:=b[i];
                        cs[n]:=i;
                end;
        sort(1,n);
        process;
        n:=0;
        for i:=1 to nn do
                if b[i]<0 then
                begin
                        inc(n);
                        a[n]:=-b[i];
                        cs[n]:=i;
                end;
        sort(1,n);
        process;
end;

procedure output;
begin
        write(go,dem mod kk);
        close(gi);
        close(go);
end;

begin
        input;
        propro;
        output;
end.
