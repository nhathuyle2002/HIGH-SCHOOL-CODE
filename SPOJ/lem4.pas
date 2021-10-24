const   ginp='ss.inp';
        gout='ss.out';
        maxn=10010;

var     gi,go:text;
        n,q:longint;
        f,tt,ht,d:array[0..4*maxn] of longint;

procedure build(id,l,r:longint);
var     m:longint;
begin
        f[id]:=r-l+1;tt[id]:=r-l+1;
        ht[id]:=r-l+1;d[id]:=0;
        if l=r then exit;
        m:=(l+r) shr 1;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
end;

procedure cn(id,l,r:longint);
begin
        if d[id]=0 then exit;
        if d[id]=-1 then
        begin
                tt[id]:=0;
                ht[id]:=0;
                f[id]:=0;
        end;
        if d[id]=1 then
        begin
                tt[id]:=r-l+1;
                ht[id]:=r-l+1;
                f[id]:=r-l+1;
        end;
        if l<r then
        begin
                d[id*2]:=d[id];
                d[id*2+1]:=d[id];
        end;
        d[id]:=0;
end;

function max(x,y,z:longint):longint;
begin
        max:=x;
        if y>max then max:=y;
        if z>max then max:=z;
end;

procedure update(id,l,r,dd,cc,k:longint);
var     m,c1,c2:longint;
begin
        cn(id,l,r);
        if (dd>r) or (cc<l) then exit;
        if (dd<=l) and (r<=cc) then
        begin
                d[id]:=k;cn(id,l,r);
                exit;
        end;
        m:=(l+r) shr 1;
        c1:=id shl 1;
        c2:=id shl 1+1;
        update(c1,l,m,dd,cc,k);
        update(c2,m+1,r,dd,cc,k);
        if tt[c1]=m-l+1 then tt[id]:=m-l+1+tt[c2]
        else tt[id]:=tt[c1];
        if ht[c2]=r-m then ht[id]:=r-m+ht[c1]
        else ht[id]:=ht[c2];
        f[id]:=max(f[c1],f[c2],ht[c1]+tt[c2]);
end;

procedure main;
var     i,cs,dd,cc:longint;
begin
        readln(gi,n);
        build(1,1,n);
        readln(gi,q);
        for i:=1 to q do
        begin
                read(gi,cs);
                if cs=3 then
                begin
                        writeln(go,f[1]);
                        readln(gi);
                end else
                begin
                        readln(gi,dd,cc);
                        if cs=1 then update(1,1,n,dd,cc,1);
                        if cs=2 then update(1,1,n,dd,cc,-1);
                end;
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
