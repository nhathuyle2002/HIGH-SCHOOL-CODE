const   ginp='ss.inp';
        gout='ss.out';
        maxn=100001;

var     gi,go:text;
        n,t,vtl,vtr,cs:longint;
        dd:array[0..4*maxn] of boolean;
        f:array[0..4*maxn] of longint;

procedure capn(x,y,z,l,r:longint);
begin
        dd[x]:=false;
        dd[y]:=not dd[y];
        dd[z]:=not dd[z];
        f[x]:=r-l+1-f[x];
end;

procedure update(id,l,r,d,c:longint);
var     m:longint;
begin
        if dd[id] then capn(id,id*2,id*2+1,l,r);
        if (l>r) or (c<l) or (d>r) then exit;
        if (d<=l) and (r<=c) then
        begin
                capn(id,id*2,id*2+1,l,r);
                exit;
        end;
        m:=(l+r) div 2;
        update(id*2,l,m,d,c);
        update(id*2+1,m+1,r,d,c);
        f[id]:=f[id*2]+f[id*2+1];
end;

function quece(id,l,r,d,c:longint):longint;
var     m:longint;
begin
        if dd[id] then capn(id,id*2,id*2+1,l,r);
        if (l>r) or (c<l) or (d>r) then exit(0);
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) div 2;
        quece:=quece(id*2,l,m,d,c)+quece(id*2+1,m+1,r,d,c);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,t);
        fillchar(dd,sizeof(dd),false);
        while t>0 do
        begin
                readln(gi,cs,vtl,vtr);
                if cs=0 then update(1,1,n,vtl,vtr)
                else writeln(go,quece(1,1,n,vtl,vtr));
                dec(t);
        end;
        close(gi);close(go);
end.
