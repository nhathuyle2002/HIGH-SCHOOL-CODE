const   ginp='milk.inp';
        gout='milk.out';

var     gi,go:text;
        n,t,ans1,ans2:longint;
        a:array[0..50001] of longint;
        f1,f2:array[0..200001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,t);
        for i:=1 to n do readln(gi,a[i]);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                f1[id]:=a[l];
                f2[id]:=a[l];
                exit;
        end;
        m:=(l+r) div 2;
        build(id*2,l,m);
        build(id*2+1,m+1,r);
        f1[id]:=min(f1[id*2],f1[id*2+1]);
        f2[id]:=max(f2[id*2],f2[id*2+1]);
end;

function query1(id,l,r,d,c:longint):longint;
var     m:longint;
begin
        if (d>r) or (c<l) then exit(maxlongint);
        if (d=l) and (c=r) then exit(f1[id]);
        m:=(l+r) div 2;
        if c<=m then exit(query1(id*2,l,m,d,c))
        else if d>m then exit(query1(id*2+1,m+1,r,d,c))
        else exit(min(query1(id*2,l,m,d,m),query1(id*2+1,m+1,r,m+1,c)));
end;

function query2(id,l,r,d,c:longint):longint;
var     m:longint;
begin
        if (d>r) or (c<l) then exit(0);
        if (d=l) and (c=r) then exit(f2[id]);
        m:=(l+r) div 2;
        if c<=m then exit(query2(id*2,l,m,d,c))
        else if d>m then exit(query2(id*2+1,m+1,r,d,c))
        else exit(max(query2(id*2,l,m,d,m),query2(id*2+1,m+1,r,m+1,c)));
end;

procedure output;
var     i,l,r:longint;
begin
        for i:=1 to t do
        begin
                readln(gi,l,r);
                writeln(go,query2(1,1,n,l,r)-query1(1,1,n,l,r));
        end;
        close(gi);close(go);
end;

begin
        input;
        build(1,1,n);
        output;
end.













