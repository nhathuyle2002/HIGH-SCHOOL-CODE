const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        pa:array[0..10010] of longint;

function root(x:longint):longint;
begin
        while pa[x]>0 do x:=pa[x];
        exit(x);
end;

procedure union(x,y:longint);
begin
        if -pa[x]<-pa[y] then
        begin
                pa[y]:=pa[x]+pa[y];
                pa[x]:=y;
        end else
        begin
                pa[x]:=pa[x]+pa[y];
                pa[y]:=x;
        end;
end;

procedure main;
var     i,x,y,z,m:longint;
begin
        for i:=0 to 10010 do pa[i]:=-1;
        readln(gi,m);
        for i:=1 to m do
        begin
                readln(gi,x,y,z);
                x:=root(x);y:=root(y);
                if z=1 then
                begin
                        if x<>y then union(x,y);
                end else
                begin
                        if x=y then writeln(go,1) else writeln(go,0);
                end;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
