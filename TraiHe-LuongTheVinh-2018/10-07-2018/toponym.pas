const   ginp='toponym.inp';
        gout='toponym.out';
        base=211;
        kk=round(1e9)+7;

var     n,r:longint;
        res:int64;
        d,ft,fs,h,v:array[0..1000010] of longint;
        a:array[0..1000010] of ansistring;

function min(x,y:longint):longint; inline;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:int64):int64; inline;
begin
        if x>y then exit(x) else exit(y);
end;

{function sosanh(var x,y:ansistring):boolean; inline;
var     i,ll:longint;
begin
        ll:=min(length(x),length(y));
        for i:=1 to ll do
                if x[i]<y[i] then exit(true) else
                if x[i]>y[i] then exit(false);
        if length(x)<length(y) then exit(true);
        exit(false);
end;}

procedure sort(l,r:longint); inline;
var     i,j,tm:longint;
        t:ansistring;
begin
        if l>=r then exit;
        i:=l;j:=r;
        tm:=random(r-l+1)+l;
        t:=a[v[tm]];
        repeat
                while {sosanh(a[v[i]],t)} a[v[i]]<t do inc(i);
                while {sosanh(t,a[v[j]])} t<a[v[j]] do dec(j);
                if i<=j then
                begin
                        tm:=v[i];v[i]:=v[j];v[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i,j:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                readln(a[i]);
                v[i]:=i;
        end;
        sort(1,n);
end;

procedure init;
var     i,ll,j:longint;
        b:array[0..1000010] of ansistring;
begin
        for i:=1 to n do b[i]:=a[v[i]];
        for i:=1 to n do a[i]:=b[i];
        h[1]:=0;
        for i:=2 to n do
        begin
                ll:=min(length(a[i]),length(a[i-1]));
                for j:=1 to ll+1 do
                begin
                        if j>ll then break;
                        if a[i,j]<>a[i-1,j] then break;
                end;
                h[i]:=j-1;
        end;
end;

procedure process;
var     i:longint;
begin
        r:=0;d[0]:=0;h[0]:=kk;
        for i:=1 to n do fs[i]:=n+1;
        for i:=1 to n do
        begin
                while (r>0) and (h[i]<h[d[r]]) do
                begin
                        fs[d[r]]:=i;
                        dec(r);
                end;
                if (h[i]=h[d[r]]) then ft[i]:=ft[d[r]] else ft[i]:=d[r];
                inc(r);d[r]:=i;
        end;
        res:=length(a[1]);
        for i:=2 to n do
                res:=max(res,int64(h[i])*(fs[i]-ft[i]));
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        init;
        process;
        close(input);close(output);
end.
