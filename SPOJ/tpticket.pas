const   ginp='ss.inp';
        gout='ss.out';
        maxn=100010;

var     gi,go:text;
        n,k,res:longint;
        d,f:array[0..5*maxn] of longint;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure capn(id:longint);
begin
        if d[id]=0 then exit;
        f[id]:=f[id]+d[id];
        d[id*2]:=d[id*2]+d[id];
        d[id*2+1]:=d[id*2+1]+d[id];
        d[id]:=0;
end;

procedure quece(id,l,r,da,cu:longint);
var     m:longint;
begin
        if l>r then exit;
        capn(id);
        if (r<da) or (cu<l) then exit;
        if (da<=l) and (r<=cu) then
        begin
                res:=max(res,f[id]);
                exit;
        end;
        m:=(l+r) shr 1;
        quece(id*2,l,m,da,cu);
        quece(id*2+1,m+1,r,da,cu);
        f[id]:=max(f[id*2],f[id*2+1]);
end;

procedure update(id,l,r,da,cu:longint);
var     m:longint;
begin
        if l>r then exit;
        capn(id);
        if (cu<l) or (r<da) then exit;
        if (da<=l) and (r<=cu) then
        begin
                inc(d[id]);
                exit;
        end;
        m:=(l+r) shr 1;
        update(id*2,l,m,da,cu);
        update(id*2+1,m+1,r,da,cu);
        f[id]:=max(f[id*2]+d[id*2],f[id*2+1]+d[id*2+1]);
end;

procedure main;
var     i,x,y,m:longint;
begin
        readln(gi,n,k,m);
        for i:=1 to m do
        begin
                readln(gi,x,y);
                res:=0;
                quece(1,1,n-1,x+1,y);
                if res<k then
                begin
                        update(1,1,n-1,x+1,y);
                        writeln(go,1);
                end
                else writeln(go,0);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
