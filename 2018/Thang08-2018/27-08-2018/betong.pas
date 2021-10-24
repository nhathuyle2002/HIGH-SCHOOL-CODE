const   ginp='betong.inp';
        gout='betong.out';

var     n,res,cou:longint;
        a,v:array[0..1000010] of longint;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[v[random(r-l+1)+l]];
        repeat
                while a[v[i]]<t do inc(i);
                while a[v[j]]>t do dec(j);
                if i<=j then
                begin
                        tm:=v[i];v[i]:=v[j];v[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     nn,i:longint;
begin
        readln(n);
        for i:=1 to n do readln(a[i]);
        nn:=n;n:=0;
        for i:=1 to nn do
                if a[i]<>a[n] then
                begin
                        inc(n);
                        a[n]:=a[i];
                        v[n]:=n;
                end;
        sort(1,n);
        a[n+1]:=0;
end;

procedure process;
var     i:longint;
begin
        cou:=1;res:=1;
        for i:=1 to n do
        begin
                if (a[v[i]]>a[v[i]-1]) and (a[v[i]]>a[v[i]+1]) then dec(cou) else
                if (a[v[i]]<a[v[i]-1]) and (a[v[i]]<a[v[i]+1]) then inc(cou);
                if a[v[i]]<>a[v[i+1]] then
                        if res<cou then res:=cou;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
