const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e15);

var     gi,go:text;
        n,k:longint;
        f:array[0..501,0..501] of int64;
        d:array[0..501] of boolean;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
var     i,m,u,v,w,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m,k);
        for i:=1 to n do
                for j:=1 to n do
                        if i<>j then f[i,j]:=oo else f[i,j]:=0;
        for i:=1 to m do
        begin
                readln(gi,u,v,w);
                f[u,v]:=min(f[u,v],w);
        end;
end;

procedure floyd(x:longint);
var     i,j:longint;
begin
        for i:=1 to n do
                for j:=1 to n do
                        f[i,j]:=min(f[i,j],f[i,x]+f[x,j]);
end;

procedure output;
var     i,j,t,x,y,cs:longint;
begin
        fillchar(d,sizeof(d),false);
        for t:=1 to k do
        begin
                read(gi,cs);
                if (cs=1) then
                begin
                        readln(gi,x);
                        if d[x]=false then
                        begin
                                d[x]:=true;
                                floyd(x);
                        end;
                end;
                if (cs=2) then
                begin
                        readln(gi,x,y);
                        if f[x,y]=oo then writeln(go,-1) else writeln(go,f[x,y]);
                end;
        end;
        close(gi);close(go);
end;

begin
        input;
        output;
end.

