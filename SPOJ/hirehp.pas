const   ginp='ss.inp';
        gout='ss.out';
        maxn=500000;
        vc=10000000000000;

var     gi,go:text;
        n:longint;
        t,la:array[0..maxn+1] of longint;
        p,f:array[0..maxn+1] of int64;
        it:array[0..4*maxn+1] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,t[i],p[i]);
                if t[i]>n then t[i]:=n;
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

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure update(j:longint;x:int64);
var     i:longint;
begin
        i:=la[j];
        while i<>0 do
        begin
                it[i]:=min(it[i],x);
                i:=i div 2;
        end;
end;

function get(id,l,r,d,c:longint):int64;
var     m:longint;
        tm1,tm2:int64;
begin
        if (l>c) or (r<d) then exit(vc);
        if (d<=l) and (r<=c) then exit(it[id]);
        m:=(l+r) div 2;
        tm1:=get(id*2,l,m,d,c);
        tm2:=get(id*2+1,m+1,r,d,c);
        get:=min(tm1,tm2);
end;

procedure process;
var     i:longint;
begin
        for i:=1 to 4*n do it[i]:=vc;
        build(1,1,n);
        update(t[1],p[1]);
        f[1]:=p[1];
        for i:=2 to n do
        begin
                f[i]:=get(1,1,n,i-1,n)+p[i];
                update(t[i],f[i]);
        end;
end;

procedure output;
begin
        write(go,get(1,1,n,n,n));
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
