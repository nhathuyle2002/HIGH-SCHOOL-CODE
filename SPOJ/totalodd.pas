const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,b,sl,res:longint;
        s:string;
        a:array[0..500000] of longint;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
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

procedure try(i,x:longint);
var     j,tm:longint;
begin
        if i=0 then exit;
        j:=1;
        while j<=9 do
        begin
                tm:=x*10+j;
                inc(sl);a[sl]:=tm;
                try(i-1,tm);
                inc(j,2);
        end;
end;

{function cnp(x:longint):longint;
var     d,c,m:longint;
begin
        d:=1;c:=sl;
        while d<>c do
        begin
                m:=(d+c) shr 1;
                if a[m]<x then d:=m+1 else c:=m;
        end;
        exit(d);
end; }

procedure main;
var     i,k,l,r:longint;
begin
        val(s,b);
        res:=round(1e8);
        if b=res then exit;
        if b mod 2=1 then inc(b);
        l:=1;r:=sl;
        repeat
                while (l<r) and (a[l]+a[r]>b) do dec(r);
                if (res>a[l]+a[r+1]) and (a[l]+a[r+1]>=b) then res:=a[l]+a[r+1];
                while (l<r) and (a[l]+a[r]<b) do inc(l);
                if (res>a[l]+a[r]) and (a[l]+a[r]>=b) then res:=a[l]+a[r];
                if a[l]+a[r]=b then break;
        until l>=r;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        try(8,0);
        sort(1,sl);
        repeat
                readln(gi,s);
                while (s='') or (s='[CASE]') do readln(gi,s);
                if s='[END]' then break;
                main;
                writeln(go,res);
        until false;
        close(gi);close(go);
end.
