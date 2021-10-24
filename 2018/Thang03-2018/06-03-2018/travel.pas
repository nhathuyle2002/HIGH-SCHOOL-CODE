const   ginp='travel.inp';
        gout='travel.out';

var     gi,go:text;
        n,n2,nn1,nn2:longint;
        s1,s2,a,sum,sl1,sl2:array[0..1000000] of int64;
        ss,dem:int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,ss);
        for i:=1 to n do read(gi,a[i]);
end;

procedure dequy(d,c,tt:longint; var s:array of int64);
var     i:longint;
begin
        for i:=d to c do
        begin
                sum[tt]:=sum[tt-1]+a[i];
                inc(dem);
                s[dem]:=sum[tt];
                if tt<c then dequy(i+1,c,tt+1,s);
        end;
end;

procedure qs(l,r:longint; var s:array of int64);
var     i,j:longint;
        x,tam:int64;
begin
        i:=l;
        j:=r;
        x:=s[random(r-l+1)+l];
        repeat
                while x>s[i] do inc(i);
                while x<s[j] do dec(j);
                if i<=j then
                begin
                        tam:=s[i];
                        s[i]:=s[j];
                        s[j]:=tam;
                        inc(i);
                        dec(j);
                end;
        until i>j;
        if l<j then qs(l,j,s);
        if i<r then qs(i,r,s);
end;

procedure demsl(nn:longint;s:array of int64;var sl:array of int64);
var     i,it,j:longint;
begin
        i:=0;
        repeat
                inc(i);
                it:=i;
                while s[i]=s[i+1] do inc(i);
                for j:=it to i do
                        sl[j]:=i-it+1;
        until i>=nn;
end;

procedure create;
var     i:longint;
begin
        n2:=n div 2;
        dem:=0;
        dequy(1,n2,1,s1);
        nn1:=dem;
        dem:=0;
        dequy(n2+1,n,1,s2);
        nn2:=dem;
        qs(1,nn1,s1);
        qs(1,nn2,s2);
        s1[nn1+1]:=100000000000000000;
        s2[nn2+1]:=100000000000000000;
        demsl(nn1,s1,sl1);
        demsl(nn2,s2,sl2);
end;

function cnp(x:int64):int64;
var     d,c,m,i:longint;
begin
        d:=1;c:=nn2;
        m:=(d+c) div 2;
        while (d<>m) and (c<>m) do
        begin
                if x<=s2[m] then c:=m else d:=m;
                m:=(d+c) div 2;
        end;
        for i:=d to c do
                if s2[i]=x then exit(sl2[i]);
        exit(0);
end;
procedure process;
var     i:longint;
        tmp,dt:int64;
begin
        dem:=0;
        for i:=1 to nn1 do
                if s1[i]=ss then inc(dem);
        for i:=1 to nn2 do
                if s2[i]=ss then inc(dem);
        i:=0;
        repeat
                inc(i);
                while s1[i]=s1[i+1] do inc(i);
                dem:=dem+sl1[i]*cnp(ss-s1[i]);
        until i>=nn1;
end;

procedure output;
begin
        if dem=0 then write(go,-1) else write(go,dem);
        close(gi);close(go);
end;

begin
        input;
        create;
        process;
        output;
end.


