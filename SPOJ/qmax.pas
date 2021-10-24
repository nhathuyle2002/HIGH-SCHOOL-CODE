const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        q:array[0..200010] of int64;
        a,dd:array[0..50010] of int64;

procedure input;
var     i,u,v,k,m:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,u,v,k);
                dd[u]:=dd[u]+k;dd[v+1]:=dd[v+1]-k;
        end;
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                q[id]:=a[l];
                exit;
        end;
        m:=(l+r) div 2;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
        q[id]:=max(q[id*2],q[id*2+1]);
end;

function try(id,l,r,d,c:longint):int64;
var     m:longint;
begin
        if (c<l) or (d>r) then exit(-maxlongint);
        if (d<=l) and (r<=c) then exit(q[id]);
        m:=(l+r) div 2;
        try:=max(try(id*2,l,m,d,c),try(id*2+1,m+1,r,d,c));
end;

procedure process;
var     i,d,c,p:longint;
begin
        for i:=1 to n do a[i]:=a[i-1]+dd[i];
        build(1,1,n);
        readln(gi,p);
        for i:=1 to p do
        begin
                readln(gi,d,c);
                writeln(go,try(1,1,n,d,c));
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
