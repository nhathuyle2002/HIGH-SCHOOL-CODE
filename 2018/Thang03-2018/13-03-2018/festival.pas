const   ginp='festival.inp';
        gout='festival.out';

var     gi,go:text;
        n,m:longint;
        c:array[0..2001,0..1001] of longint;

procedure input;
var     i,u,v:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,u,v);
                inc(c[u,0]);
                c[u,c[u,0]]:=v;
                inc(c[v+n,0]);
                c[v,c[v+n,0]]:=u;
        end;
end;

procedure qs(h,l,r:longint);
var     i,j,x,tmp:longint;
begin
        i:=l;j:=r;
        x:=c[h,random(r-l+1)+l];
        repeat
                while x>c[h,i] do inc(i);
                while x<c[h,j] do dec(j);
                if i<=j then
                begin
                        tmp:=c[h,i];
                        c[h,i]:=c[h,j];
                        c[h,j]:=tmp;
                        inc(i);dec(j);
                end;
        until i>j;
        if l<j then qs(h,l,j);
        if i<r then qs(h,i,r);
end;

procedure process;
var     i:longint;
begin
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

