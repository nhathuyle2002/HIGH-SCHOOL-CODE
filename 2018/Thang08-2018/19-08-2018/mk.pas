const   ginp='mk.inp';
        gout='mk.out';
        base=311;
        kk=trunc(1e9)+7;

var     n,tb,cou,res,tc:longint;
        a:array[0..20010] of string[10];
        c:array[0..20010] of longint;
        pow:array[0..10] of int64;
        h:array[0..20010,0..10] of int64;
        d,b:array[0..20010] of int64;
        dd:array[0..20010] of boolean;

procedure sorta(l,r:longint);
var     i,j,t:longint;
        tm:string[10];
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=length(a[random(r-l+1)+l]);
        repeat
                while length(a[i])<t do inc(i);
                while t<length(a[j]) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sorta(l,j);sorta(i,r);
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i]<t do inc(i);
                while t<b[j] do dec(j);
                if i<=j then
                begin
                        tm:=b[i];b[i]:=b[j];b[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i,j:longint;
begin
        readln(n);
        for i:=1 to n do readln(a[i]);
        sorta(1,n);
        pow[0]:=1;
        for i:=1 to 10 do pow[i]:=(pow[i-1]*base) mod kk;
        for i:=1 to n do
                for j:=1 to length(a[i]) do
                        h[i,j]:=(h[i,j-1]*base+ord(a[i,j])) mod kk;
end;

function cnp(x:int64):longint;
var     l,r,m:longint;
begin
        x:=(x+kk*kk) mod kk;
        if (x<b[1]) or (x>b[cou]) then exit(0);
        l:=1;r:=cou;
        while l<r do
        begin
                m:=(l+r) shr 1;
                if b[m]>=x then r:=m else l:=m+1;
        end;
        if b[l]=x then exit(l) else exit(0);
end;

procedure process;
var     i,j,k,v:longint;
begin
        res:=0;
        fillchar(dd,sizeof(dd),true);
        dd[0]:=false;
        i:=0;b[0]:=-1;d[0]:=0;
        repeat
                inc(i);
                tb:=1;b[1]:=h[i,length(a[i])];
                while (i<n) and (length(a[i+1])=length(a[i])) do
                begin
                        inc(i);
                        inc(tb);b[tb]:=h[i,length(a[i])];
                end;
                sort(1,tb);
                cou:=0;
                for j:=1 to tb do
                        if b[j]=b[cou] then inc(d[cou]) else
                        begin
                                res:=res+d[cou]*(d[cou]-1);
                                inc(cou);d[cou]:=1;b[cou]:=b[j];
                        end;
                res:=res+d[cou]*(d[cou]-1);
                for j:=i+1 to n do
                begin
                        tc:=0;
                        for k:=length(a[i]) to length(a[j]) do
                        begin
                                v:=cnp(h[j,k]-h[j,k-length(a[i])]*pow[length(a[i])]);
                                if dd[v] then
                                begin
                                        inc(tc);c[tc]:=v;
                                        res:=res+d[v];
                                        dd[v]:=false;
                                end;
                        end;
                        for k:=1 to tc do dd[c[k]]:=true;
                end;
        until i>=n;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
