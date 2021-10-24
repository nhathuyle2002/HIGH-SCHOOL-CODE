const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e4)+5;

var     gi,go:text;
        n:longint;
        y,link:array[-1001..1001] of longint;
        d:array[-1001..1001] of boolean;
        f:array[0..1001,0..2] of longint;
        head:array[0..1001] of longint;

procedure add(i,u,v:longint);
begin
        y[i]:=v;
        link[i]:=head[u];
        head[u]:=i;
end;

function min2(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function min3(x,y,z:longint):longint;
begin
        min3:=x;
        if y<min3 then min3:=y;
        if z<min3 then min3:=z;
end;

procedure create;
var     i,u,v:longint;
begin
        for i:=1 to n do head[i]:=0;
        for i:=-n to n do
        begin
                d[i]:=true;
                link[i]:=0;
        end;
        for i:=1 to n-1 do
        begin
                readln(gi,u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
end;

procedure dfs(u:longint);
var     i,v,sum,tm:longint;
begin
        i:=head[u];
        f[u,0]:=0;f[u,1]:=oo;f[u,2]:=1;
        sum:=0;
        while i<>0 do
        begin
                if d[i] then
                begin
                        d[-i]:=false;
                        v:=y[i];dfs(v);
                        f[u,0]:=f[u,0]+f[v,1];
                        f[u,2]:=f[u,2]+min3(f[v,0],f[v,1],f[v,2]);
                        sum:=sum+min2(f[v,1],f[v,2]);
                end;
                i:=link[i];
        end;
        i:=head[u];
        while i<>0 do
        begin
                if d[i] then
                begin
                        v:=y[i];
                        tm:=sum-min2(f[v,1],f[v,2])+f[v,2];
                        f[u,1]:=min2(f[u,1],tm);
                end;
                i:=link[i];
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        repeat
                readln(gi,n);
                if n=0 then break;
                create;
                dfs(1);
                writeln(go,min2(f[1,1],f[1,2]));
        until false;
        close(gi);close(go);
end.
