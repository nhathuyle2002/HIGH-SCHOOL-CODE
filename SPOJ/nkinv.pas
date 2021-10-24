const   ginp='ss.inp';
        gout='ss.out';
        maxn=60010;

var     gi,go:text;
        n,res:longint;
        a,la:array[0..maxn] of longint;
        f:array[0..4*maxn] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,a[i]);
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                la[l]:=id;
                exit;
        end;
        m:=(l+r) shr 1;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
end;

procedure update(id:longint);
begin
        if id<1 then exit;
        inc(f[id]);
        update(id shr 1);
end;

function quece(id,l,r,d,c:longint):longint;
var     m:longint;
begin
        if (c<l) or (r<d) then exit(0);
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) shr 1;
        quece:=quece(id*2,l,m,d,c)+quece(id*2+1,m+1,r,d,c);
end;

procedure process;
var     i:longint;
begin
        build(1,1,maxn);
        res:=0;
        for i:=1 to n do
        begin
                res:=res+quece(1,1,maxn,a[i]+1,maxn);
                update(la[a[i]]);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        write(go,res);
        close(gi);close(go);
end.
