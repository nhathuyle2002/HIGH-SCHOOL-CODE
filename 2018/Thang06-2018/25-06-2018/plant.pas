const   ginp='plant.inp';
        gout='plant.out';
        maxx=1000010;

var     gi,go:text;
        g:array[0..4*maxx] of longint;

procedure capn(id,l,r:longint);
begin
        if l<r then
        begin
                g[id<<1]:=g[id]+g[id<<1];
                g[id<<1+1]:=g[id]+g[id<<1+1];
                g[id]:=0;
        end;
end;

function quece(id,l,r,v:longint):longint;
var     m:longint;
begin
        capn(id,l,r);
        if (v<l) or (v>r) then exit(0);
        if (v=l) and (v=r) then
        begin
                quece:=g[id];
                g[id]:=0;exit;
        end;
        m:=(l+r)>>1;
        quece:=quece(id<<1,l,m,v)+quece(id<<1+1,m+1,r,v);
end;

procedure update(id,l,r,d,c:longint);
var     m:longint;
begin
        capn(id,l,r);
        if (d>r) or (c<l) then exit;
        if (d<=l) and (r<=c) then
        begin
                g[id]:=g[id]+1;capn(id,l,r);
                exit;
        end;
        m:=(l+r)>>1;
        update(id<<1,l,m,d,c);
        update(id<<1+1,m+1,r,d,c);
end;

procedure main;
var     i,l,r,n:longint;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,l,r);
                writeln(go,quece(1,1,maxx,l)+quece(1,1,maxx,r));
                if l+1<=r-1 then update(1,1,maxx,l+1,r-1);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
