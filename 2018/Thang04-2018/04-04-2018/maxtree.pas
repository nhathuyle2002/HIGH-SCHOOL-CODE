const   ginp='maxtree.inp';
        gout='maxtree.out';

var     gi,go:text;
        n:longint;
        d:array[0..50010] of boolean;
        head:array[0..50100] of longint;
        x,y,w,link:array[-50010..50010] of longint;
        f:array[0..50010] of int64;
        ans:int64;

procedure ad(i,u,v,c:longint);
begin
        x[i]:=u;y[i]:=v;w[i]:=c;
        link[i]:=head[u];head[u]:=i;
end;

procedure input;
var     i,u,v,c:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n-1 do
        begin
                readln(gi,u,v,c);
                ad(i,u,v,c);
                ad(-i,v,u,c);
        end;
end;

function max(xx,yy:int64):int64;
begin
        if xx>yy then exit(xx) else exit(yy);
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        d[u]:=false;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if d[v] then
                begin
                       dfs(v);
                       if f[v]+w[i]>0 then f[u]:=f[u]+f[v]+w[i];
                end;
                i:=link[i];
        end;
        ans:=max(ans,f[u]);
end;

procedure output;
begin
        fillchar(d,sizeof(d),true);
        dfs(1);
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        output;
end.









