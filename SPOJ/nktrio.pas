const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        pa:array[0..1001] of longint;
        d:array[-1..1001,-1..1001] of longint;

procedure input;
var     i,j:longint;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                for j:=1 to n do read(gi,d[i,j]);
                readln(gi);
        end;
end;

procedure dfs(u:longint);
var     v:longint;
begin
        for v:=1 to n do
        if d[u,v]=1 then
        begin
                if pa[v]=0 then
                begin
                        pa[v]:=u;
                        dfs(v);
                end else
                if (pa[u]>0) and (d[v,pa[u]]=1) then
                begin
                        write(go,u,' ',v,' ',pa[u]);
                        close(gi);close(go);
                        halt;
                end;
        end;
end;

procedure process;
var     i:longint;
begin
        fillchar(pa,sizeof(pa),0);
        for i:=1 to n do
                if pa[i]=0 then
                begin
                        pa[i]:=-1;
                        dfs(i);
                end;
        write(go,-1,' ',-1,' ',-1);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
