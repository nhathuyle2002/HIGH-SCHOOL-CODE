const   ginp='ss.inp';
        gout='ss.out';
        maxn=200001;
        oo=trunc(1e9);

var     gi,go:text;
        n,res,gma:longint;
        a,la:array[0..maxn] of longint;
        ma,f:array[0..4*maxn] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
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
        if y>max3 then max3:=y;
        if z>max3 then max3:=z;
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                f[id]:=-oo;
                ma[id]:=a[l];
                la[l]:=id;
                exit;
        end;
        m:=(l+r) shr 1;
        build(id shl 1,l,m);
        build(id shl 1+1,m+1,r);
        ma[id]:=max(ma[id*2],ma[id*2+1]);
        f[id]:=max3(f[id*2],f[id*2+1],ma[id*2]+ma[id*2+1]);
end;

procedure update(id:longint);
begin
        if id<1 then exit;
        ma[id]:=max(ma[id*2],ma[id*2+1]);
        f[id]:=max3(f[id*2],f[id*2+1],ma[id*2]+ma[id*2+1]);
        update(id shr 1);
end;

procedure quece(id,l,r,d,c:longint);
var     m:longint;
begin
        if (c<l) or (r<d) then exit;
        if (d<=l) and (r<=c) then
        begin
                res:=max3(res,f[id],gma+ma[id]);
                gma:=max(gma,ma[id]);
                exit;
        end;
        m:=(l+r) shr 1;
        quece(id*2,l,m,d,c);
        quece(id*2+1,m+1,r,d,c);
end;

procedure process;
var     i,m,d,c:longint;
        x:char;
begin
        build(1,1,n);
        readln(gi,m);
        for i:=1 to m do
        begin
                readln(gi,x,d,c);
                if x='U' then
                begin
                        ma[la[d]]:=c;
                        update(la[d] shr 1);
                end else
                if x='Q' then
                begin
                        res:=-oo;gma:=-oo;
                        quece(1,1,n,d,c);
                        writeln(go,res);
                end;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.

