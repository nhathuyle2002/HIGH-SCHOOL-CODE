const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n,k:longint;
        p,p0,la:array[0..500001] of longint;
        q:array[0..4*500000+1] of longint;
        ans:int64;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        read(gi,k);
        for i:=1 to n do
                for j:=1 to m do
                begin
                        p[m*(i-1)+j]:=n*(j-1)+i;
                        p0[n*(j-1)+i]:=m*(i-1)+j;
                end;
end;

procedure process1;
var     i:longint;
begin
        for i:=1 to m*n do
                if p[i]<>i then
                begin
                        inc(ans);
                        p[p0[i]]:=p[i];
                        p0[p[i]]:=p0[i];
                end;
end;

procedure build(id,l,r:longint);
var     mid:longint;
begin
        if l=r then
        begin
                la[l]:=id;
                exit;
        end;
        mid:=(l+r) div 2;
        build(id*2,l,mid);
        build(id*2+1,mid+1,r);
end;

procedure update(id:longint);
begin
        if id<1 then exit;
        inc(q[id]);
        update(id div 2);
end;

function quece(id,l,r,d,c:longint):longint;
var     mid:longint;
begin
        if (l>r) then exit(0);
        if (d>r) or (c<l) then exit(0);
        if (d<=l) and (c>=r) then exit(q[id]);
        mid:=(l+r) div 2;
        quece:=quece(id*2,l,mid,d,c)+quece(id*2+1,mid+1,r,d,c);
end;

procedure process2;
var     i:longint;
begin
        build(1,1,m*n);
        for i:=1 to m*n do
        begin
                ans:=ans+quece(1,1,m*n,p[i]+1,m*n);
                update(la[p[i]]);
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        if k=1 then process1 else process2;
        output;
end.
