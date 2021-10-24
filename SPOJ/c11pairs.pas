const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,r:longint;
        ans:int64;
        a,q:array[0..500000] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i]);
end;

procedure push(i:longint);
begin
        while (0<r) and (q[r]<a[i]) do dec(r);
        inc(r);q[r]:=a[i];
end;

function bina_se(x:longint):longint;
var     d,c,m:longint;
begin
        if x>=q[1] then exit(r);
        if x<q[r] then exit(1);
        d:=1;c:=r;
        while d<>c do
        begin
                m:=(d+c) div 2;
                if q[m]<=x then c:=m else d:=m+1;
        end;
        dec(d);
        exit(r-d+1);
end;

procedure process;
var     i:longint;
begin
        r:=1;ans:=0;
        for i:=2 to n do
        begin
                push(i-1);
                ans:=ans+bina_se(a[i]);
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.


