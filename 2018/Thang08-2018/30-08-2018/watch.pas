const   ginp='watch.inp';
        gout='watch.out';
        kk=trunc(1e9)+13;
        base=11;
        maxn=100010;

var     n,q:longint;
        a:ansistring;
        pow:array[0..maxn] of int64;
        mh:array[0..9,0..maxn] of int64;
        g:array[0..4*maxn] of longint;
        f:array[0..4*maxn] of int64;

procedure build(id,l,r:longint);
var     m:longint;
begin
        g[id]:=-1;
        if l=r then
        begin
                f[id]:=(pow[l]*(ord(a[l])-47)) mod kk;
                exit;
        end;
        m:=(l+r) shr 1;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
        f[id]:=(f[id*2]+f[id*2+1]) mod kk;
end;

procedure enter;
var     x,i,m,k:longint;
begin
        readln(n,m,k);
        q:=m+k;
        readln(a);
        pow[0]:=1;
        for i:=1 to n do pow[i]:=(pow[i-1]*base) mod kk;
        for x:=0 to 9 do
                for i:=1 to n do
                        mh[x,i]:=(mh[x,i-1]+pow[i]*(x+1)) mod kk;
        build(1,1,n);
end;

procedure capn(id,l,r:longint);
var     m:longint;
begin
        if g[id]=-1 then exit;
        f[id]:=(mh[g[id],r-l+1]*pow[l-1]) mod kk;
        if l<r then
        begin
                g[id*2]:=g[id];
                g[id*2+1]:=g[id];
        end;
        g[id]:=-1;
end;

procedure update(id,l,r,d,c,x:longint);
var     m:longint;
begin
        capn(id,l,r);
        if (c<l) or (r<d) then exit;
        if (d<=l) and (r<=c) then
        begin
                g[id]:=x;
                capn(id,l,r);
                exit;
        end;
        m:=(l+r) shr 1;
        update(id*2,l,m,d,c,x);
        update(id*2+1,m+1,r,d,c,x);
        f[id]:=(f[id*2]+f[id*2+1]) mod kk;
end;

function quece(id,l,r,d,c:longint):int64;
var     m:longint;
begin
        capn(id,l,r);
        if (r<d) or (c<l) then exit(0);
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) shr 1;
        quece:=(quece(id*2,l,m,d,c)+quece(id*2+1,m+1,r,d,c)) mod kk;
        f[id]:=(f[id*2]+f[id*2+1]) mod kk;
end;

procedure process;
var     i,id,l,r,x:longint;
begin
        for i:=1 to q do
        begin
                readln(id,l,r,x);
                if id=2 then
                begin
                        if (quece(1,1,n,l,r-x)*pow[x]) mod kk=quece(1,1,n,l+x,r) then
                        writeln('YES') else writeln('NO');
                end else
                update(1,1,n,l,r,x);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
