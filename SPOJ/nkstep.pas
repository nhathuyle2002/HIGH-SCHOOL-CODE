const   ginp='ss.inp';
        gout='ss.out';
        maxn=50000;

var     gi,go:text;
        f:array[0..maxn] of int64;

procedure create;
var     i:longint;
begin
        f[1]:=1;
        for i:=2 to maxn do
                f[i]:=f[i-1]+i-1+i;
end;

function cnp(x:int64):int64;
var     d,c,m:longint;
begin
        if x=0 then exit(0);
        if x<4 then exit(x);
        d:=1;c:=maxn;
        while d<>c do
        begin
                m:=(d+c) div 2;
                if f[m]<=x then d:=m+1 else c:=m;
        end;
        dec(d);
        if f[d]=x then exit(2*d-1);
        cnp:=2*d-1;
        m:=x-f[d];
        cnp:=cnp+m div d;
        if m mod d<>0 then inc(cnp);
end;

procedure main;
var     l,r:int64;
        i,t:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for i:=1 to t do
        begin
                readln(gi,l,r);
                writeln(go,cnp(abs(l-r)));
        end;
        close(gi);close(go);
end;

begin
        create;
        main;
end.
