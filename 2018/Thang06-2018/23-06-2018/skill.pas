const   ginp='skill.inp';
        gout='skill.out';

var     gi,go:text;
        n:longint;
        maxa,cf,cm,m,res:int64;
        a,sum:array[0..100010] of int64;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure input;
var     i:longint;
begin
        readln(gi,n,maxa,cf,cm,m);
        for i:=1 to n do read(gi,a[i]);
        sort(1,n);
        for i:=1 to n do sum[i]:=sum[i-1]+a[i];
end;

function cnp(x:int64;l,r:longint):longint;
var     mid:longint;
begin
        while l<>r do
        begin
                mid:=(l+r) shr 1;
                if a[mid]*mid-sum[mid]>x then r:=mid else l:=mid+1;
        end;
        exit(l-1);
end;

procedure process;
var     i,tm:longint;
        tmp:int64;
begin
        if maxa*n-sum[n]<=m then
        begin
                res:=cf*n+maxa*cm;
                exit;
        end;
        res:=0;
        for i:=n downto 1 do
        begin
                tmp:=maxa*(n-i)-sum[n]+sum[i];
                if tmp>m then break;
                tm:=cnp(m-tmp,1,i+1);
                tmp:=(m-tmp+sum[tm]) div tm;
                tmp:=(n-i)*cf+tmp*cm;
                if tmp>res then res:=tmp;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,res);
        close(gi);close(go);
end.












