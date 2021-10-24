const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e9);

var     gi,go:text;
        n,p:longint;
        d:array[0..201,0..201] of boolean;
        w:array[0..201] of longint;
        f,t:array[0..201,0..201] of longint;

procedure input;
var     i,u,v:longint;
begin
        readln(gi,n,p);
        for i:=1 to n do read(gi,w[i]);
        readln(gi);
        fillchar(d,sizeof(d),false);
        for i:=1 to n-1 do
        begin
                readln(gi,u,v);
                d[u,v]:=true;
                d[v,u]:=true;
        end;
end;

procedure dfs(u:longint);
var     v,j,i:longint;
begin
        f[u,1]:=w[u];
        for v:=1 to n do
                if d[u,v] then
                begin
                        d[v,u]:=false;
                        dfs(v);
                        for i:=p downto 1 do
                                for j:=1 to i-1 do
                                        if f[u,i]<f[u,j]+f[v,i-j] then
                                        begin
                                                f[u,i]:=f[u,j]+f[v,i-j];
                                                t[v,i]:=i-j;
                                        end;
                end;
end;

procedure trace(u,i:longint);
var     v:longint;
begin
        for v:=n downto 1 do
                if (d[u,v]) and (t[v,i]>0) then
                begin
                        trace(v,t[v,i]);
                        dec(i,t[v,i]);
                end;
        write(go,u,' ');
end;

procedure process;
var     i,j,u:longint;
begin
        for i:=1 to n do
                for j:=1 to p do f[i,j]:=-oo;
        dfs(1);
        u:=1;
        for i:=2 to n do
                if f[i,p]>f[u,p] then u:=i;
        trace(u,p);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
