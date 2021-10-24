const   ginp='ss.inp';
        gout='ss.out';
        maxn=100001;
        oo=trunc(1e9);

var     gi,go:text;
        n,res:longint;
        la:array[0..maxn] of longint;
        f:array[0..4*maxn] of longint;
        a:array[1..3,0..maxn] of longint;
        v:array[0..maxn,1..3] of longint;

procedure input;
var     i,j:longint;
begin
        readln(gi,n);
        for i:=1 to 3 do
        begin
                for j:=1 to n do
                begin
                        read(gi,a[i,j]);
                        v[a[i,j],i]:=j;
                end;
        end;
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                la[l]:=id;
                exit;
        end;
        m:=(l+r) div 2;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure update(id,x:longint);
begin
        if id<1 then exit;
        f[id]:=min(f[id],x);
        update(id shr 1,x);
end;

function quece(id,l,r,d,c:longint):longint;
var     m:longint;
begin
        if (c<l) or (r<d) then exit(oo);
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) div 2;
        quece:=min(quece(id*2,l,m,d,c),quece(id*2+1,m+1,r,d,c));
end;

procedure process;
var     i,tm1,tm2:longint;
begin
        build(1,1,n);
        for i:=1 to 4*n do f[i]:=oo;
        res:=0;
        for i:=1 to n do
        begin
                tm1:=v[a[1,i],2];
                tm2:=v[a[1,i],3];
                if quece(1,1,n,1,tm2)>tm1 then inc(res);
                update(la[tm2],tm1);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,res);
        close(gi);close(go);
end.
