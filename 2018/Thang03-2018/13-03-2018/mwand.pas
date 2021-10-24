const   ginp='mwand.inp';
        gout='mwand.out';
        kk=1000000007;

var     gi,go:text;
        n,nn:longint;
        dem:int64;
        a,b:array[0..100001] of int64;
        cs,f,child:array[0..100001] of longint;

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

function cnp1(i:longint;x:int64):longint;
var     d,c,m:longint;
begin
        d:=i+1;c:=n;
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

function cnp2(i:longint;x:int64):longint;
var     d,c,m:longint;
begin
        d:=i+1;c:=n;
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

procedure process;
var     i,tmp1,tmp2,j:longint;
begin
        fillchar(f,sizeof(f),0);
        fillchar(child,sizeof(child),0);
        a[0]:=maxlongint;
        for i:=1 to n-1 do
        begin
                if (a[i]<>a[i-1]) then
                begin
                        tmp1:=cnp1(i,3*a[i]);
                        tmp2:=cnp2(i,3*a[i]);
                end;
                if (tmp1<>0) and (tmp2<>0) then
                begin
                        for j:=tmp2 to tmp1 do
                                if cs[j]>cs[i] then
                                begin
                                        inc(child[j]);
                                        if child[i]>0 then dem:=(dem+child[i]) mod kk;
                                end;
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
