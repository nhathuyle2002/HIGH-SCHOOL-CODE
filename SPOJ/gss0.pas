const   ginp='ss.inp';
        gout='ss.out';
        maxn=50001;
        oo=trunc(1e9);

var     gi,go:text;
        n:longint;
        a,s:array[0..maxn] of longint;
        ma,mi,f:array[0..4*maxn] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        s[0]:=0;
        for i:=1 to n do
        begin
                read(gi,a[i]);
                s[i]:=s[i-1]+a[i];
        end;
        readln(gi);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
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
                ma[id]:=s[l];
                mi[id]:=s[l];
                f[id]:=-oo;
                exit;
        end;
        m:=(l+r) div 2;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
        ma[id]:=max(ma[id*2],ma[id*2+1]);
        mi[id]:=min(mi[id*2],mi[id*2+1]);
        f[id]:=max3(f[id*2],f[id*2+1],ma[id*2+1]-mi[id*2]);
end;

procedure quece(id,l,r,d,c:longint;var res,gmi,gma:longint);
var     m,x1,x2,x3,y1,y2,y3:longint;
begin
        if (c<l) or (d>r) then
        begin
                res:=-oo;
                gmi:=oo;
                gma:=-oo;
                exit;
        end;
        if (d<=l) and (r<=c) then
        begin
                res:=f[id];
                gmi:=mi[id];
                gma:=ma[id];
                exit;
        end;
        m:=(l+r) div 2;
        x1:=-oo;x2:=oo;x3:=-oo;
        y1:=-oo;y2:=oo;y3:=-oo;
        quece(id*2,l,m,d,c,x1,x2,x3);
        quece(id*2+1,m+1,r,d,c,y1,y2,y3);
        res:=max3(x1,y1,y3-x2);
        gmi:=min(x2,y2);
        gma:=max(x3,y3);
end;

procedure process;
var     i,m,d,c,gmi,gma,res:longint;
begin
        build(1,0,n);
        readln(gi,m);
        for i:=1 to m do
        begin
                readln(gi,d,c);
                res:=-oo;gmi:=oo;gma:=-oo;
                quece(1,0,n,d-1,c,res,gmi,gma);
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

