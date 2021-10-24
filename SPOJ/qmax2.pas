const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        q,s:array[0..200010] of int64;

procedure update(id:longint);
var     tm:longint;
begin
        if id<=1 then exit;
        tm:=id div 2;
        if q[id]+s[id]>q[tm] then
        begin
                q[tm]:=q[id]+s[id];
                update(tm);
        end;
end;

procedure try1(id,l,r,d,c,k:longint);
var     m:longint;
begin
        if (c<l) or (d>r) then exit;
        if (d<=l) and (r<=c) then
        begin
                s[id]:=s[id]+k;
                update(id);
                exit;
        end;
        m:=(l+r) div 2;
        try1(id*2,l,m,d,c,k);
        try1(id*2+1,m+1,r,d,c,k);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

function try2(id,l,r,d,c:longint):int64;
var     m:longint;
begin
        if (c<l) or (d>r) then exit(0);
        if (d<=l) and (r<=c) then exit(q[id]+s[id]);
        m:=(l+r) div 2;
        try2:=max(try2(id*2,l,m,d,c),try2(id*2+1,m+1,r,d,c))+s[id];
end;

procedure main;
var     i,d,c,m,k:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                read(gi,k);
                if k=0 then
                begin
                        readln(gi,d,c,k);
                        try1(1,1,n,d,c,k);
                end else
                begin
                        readln(gi,d,c);
                        writeln(go,try2(1,1,n,d,c));
                end;
        end;
        close(gi);close(go);
end;

begin
        main;
end.

