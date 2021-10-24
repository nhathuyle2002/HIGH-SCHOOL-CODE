const   ginp='ss.inp';
        gout='ss.out';
        maxn=100000;

var     gi,go:text;
        n,st:longint;
        a:array[0..maxn] of int64;
        f:array[0..maxn*4] of int64;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if (l=r) then
        begin
                f[id]:=a[l];
                exit;
        end;
        m:=(l+r) div 2;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
        f[id]:=max(f[id*2],f[id*2+1]);
end;

procedure create;
var     i:longint;
begin
        a[0]:=0;a[1]:=1;
        for i:=2 to maxn do
                if i mod 2=0 then a[i]:=a[i div 2]
                else a[i]:=a[i div 2]+a[i div 2+1];
        build(1,1,maxn);
end;

function quece(id,l,r,d,c:longint):int64;
var     m:longint;
begin
        if (d>r) or (c<l) then exit(0);
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) div 2;
        quece:=max(quece(id*2,l,m,d,c),quece(id*2+1,m+1,r,d,c));
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        create;
        readln(gi,st);
        while st>0 do
        begin
                readln(gi,n);
                writeln(go,quece(1,1,maxn,1,n));
                dec(st);
        end;
        close(gi);close(go);
end.
