const   ginp='ss.inp';
        gout='ss.out';
        maxn=50001;
        oo=trunc(1e9);

var     gi,go:text;
        n,res:longint;
        a:array[0..maxn] of longint;
        f,ft,fs,s:array[0..4*maxn] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        s[0]:=0;
        for i:=1 to n do read(gi,a[i]);
        readln(gi);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function max3(x,y,z:longint):longint;
begin
        max3:=x;
        if max3<y then max3:=y;
        if max3<z then max3:=z;
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                f[id]:=a[l];
                ft[id]:=a[l];
                fs[id]:=a[l];
                s[id]:=a[l];
                exit;
        end;
        m:=(l+r) div 2;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
        s[id]:=s[id*2]+s[id*2+1]
        ft[id]:=max(ft[id*2],s[id*2]+ft[id*2+1]);
        fs[id]:=max(s[id*2+1]+fs[id*2],fs[id*2+1]);
        f[id]:=max3(f[id*2],f[id*2+1],fs[id*2]+ft[id*2+1]);
end;

procedure quece(id,l,r,d,c:longint);
var     m:longint;
begin
        if (c<l) or (d>r) then exit;
        if (d<=l) and (r<=c) then
        begin

                exit;
        end;
        m:=(l+r) div 2;
        quece(id*2,l,m,d,c);
        quece(id*2+1,m+1,r,d,c);
end;

procedure process;
var     i,m,d,c,j:longint;
begin
        build(1,1,n);
        readln(gi,m);
        for i:=1 to m do
        begin
                readln(gi,d,c);

                writeln(go,res);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
