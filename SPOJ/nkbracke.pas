const   ginp='';
        gout='';
        maxn=100001;

var     gi,go:text;
        n,q:longint;
        f,t:array[0..4*maxn] of longint;
        la:array[0..maxn] of longint;
        a:ansistring;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if (l=r) then
        begin
                if a[l]='(' then f[id]:=1 else f[id]:=-1;
                t[id]:=f[id];
                la[l]:=id;
                exit;
        end;
        m:=(l+r) shr 1;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
        f[id]:=f[id*2]+f[id*2+1];
        t[id]:=min(t[id*2],f[id*2]+t[id*2+1]);
end;

procedure update(id:longint);
begin
        if id=0 then exit;
        f[id]:=f[id*2]+f[id*2+1];
        t[id]:=min(t[id*2],f[id*2]+t[id*2+1]);
        update(id shr 1);
end;

procedure quece(id,l,r,d,c:longint);
var     m:longint;
begin
        if (c<l) or (d>r) then exit;
        if (d<=l) and (r<=c) then
        begin
                t[0]:=min(t[0],f[0]+t[id]);
                f[0]:=f[0]+f[id];
                exit;
        end;
        m:=(l+r) shr 1;
        quece(id*2,l,m,d,c);
        quece(id*2+1,m+1,r,d,c);
end;

procedure main;
var     i,cs,d,c:longint;
        x:char;
begin
        readln(gi,n,q);
        readln(gi,a);
        build(1,1,n);
        for i:=1 to q do
        begin
                read(gi,cs);
                if cs=0 then
                begin
                        read(gi,d,x);while x=' ' do read(gi,x);readln(gi);
                        if (x='(') then
                        begin
                                f[la[d]]:=1;t[la[d]]:=1;
                                update(la[d] shr 1);
                        end else
                        if (x=')') then
                        begin
                                f[la[d]]:=-1;t[la[d]]:=-1;
                                update(la[d] shr 1);
                        end;
                end else
                begin
                        readln(gi,d,c);
                        t[0]:=0;f[0]:=0;quece(1,1,n,d,c);
                        if (f[0]=0) and (t[0]>=0) then write(go,1) else write(go,0);
                end;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.

