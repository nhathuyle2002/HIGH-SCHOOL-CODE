const   ginp='ss.inp';
        gout='ss.out';
        maxn=14143;

var     gi,go:text;
        n,r,ans:longint;
        u,a:array[0..maxn] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i]);
        for i:=1 to maxn do u[i]:=u[i-1]+i;
end;

function tknp(x:longint):boolean;
var     d,c,m:longint;
begin
        d:=1;c:=maxn;
        while d<>c do
        begin
                m:=(d+c) div 2;
                if u[m]=x then exit(true);
                if u[m]<x then d:=m+1 else c:=m;
        end;
        if u[d]=x then exit(true) else exit(false);
end;

procedure process;
var     i:longint;
begin
        r:=0;ans:=0;
        for i:=1 to n+1 do
        begin
                if (a[i]<a[i-1]) then r:=0;
                if tknp(a[i]) then inc(r) else r:=0;
                if r>ans then ans:=r;
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






