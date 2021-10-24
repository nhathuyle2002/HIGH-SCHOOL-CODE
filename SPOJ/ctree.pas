const   ginp='ss.inp';
        gout='ss.out';
        maxn=10000;
        oo=trunc(1e9);

var     gi,go:text;
        n,cou:longint;
        link,x,y:array[-maxn..maxn] of longint;
        head,d,re:array[0..maxn] of longint;
        f:array[0..maxn,1..3] of longint;

procedure add(i,u,v:longint);
begin
        x[i]:=u;y[i]:=v;
        link[i]:=head[u];head[u]:=i;
end;

procedure input;
var     i,u,v:longint;
begin
        readln(gi,n);
        for i:=1 to n-1 do
        begin
                readln(gi,u,v);
                add(i,u,v);add(-i,v,u);
        end;
end;

function min(aa,bb:longint):longint;
begin
        if aa<bb then exit(aa) else exit(bb);
end;

procedure dfs(u:longint);
var     i,v,j,k,gtm:longint;
begin
        inc(cou);d[u]:=cou;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if d[v]=0 then dfs(v);
                i:=link[i];
        end;
        for j:=1 to 3 do
        begin
                f[u,j]:=j;
                i:=head[u];
                while i<>0 do
                begin
                        v:=y[i];
                        if d[v]>d[u] then
                        begin
                                gtm:=oo;
                                for k:=1 to 3 do
                                        if (k<>j) then gtm:=min(gtm,f[v,k]);
                                f[u,j]:=f[u,j]+gtm;
                        end;
                        i:=link[i];
                end;
        end;
end;

procedure trace(u,j:longint);
var     i,v,k,jm,gtm:longint;
begin
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if d[v]>d[u] then
                begin
                        gtm:=oo;
                        for k:=1 to 3 do
                                if (k<>j) and (f[v,k]<gtm) then
                                begin
                                        gtm:=f[v,k];
                                        jm:=k;
                                end;
                        re[v]:=jm;
                        trace(v,jm);
                end;
                i:=link[i];
        end;
end;

procedure output;
var     j,gtm,jm,i:longint;
begin
        cou:=0;
        fillchar(d,sizeof(d),0);
        dfs(1);
        jm:=1;
        for j:=2 to 3 do
                if f[1,j]<f[1,jm] then jm:=j;
        re[1]:=jm;trace(1,jm);
        writeln(go,f[1,re[1]]);
        for i:=1 to n do writeln(go,re[i]);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        output;
        close(gi);close(go);
end.
