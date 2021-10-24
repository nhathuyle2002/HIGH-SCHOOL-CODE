const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e7);

var     gi,go:text;
        n,cou,r:longint;
        num,low,f,ch,q,sl,sh:array[0..100001] of longint;
        d:array[0..100001] of boolean;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure dfs(u:longint);
var     v:longint;
begin
        inc(cou);
        num[u]:=cou;low[u]:=oo;
        d[u]:=false;
        inc(r);q[r]:=u;
        v:=ch[u];
        if sh[v]=0 then
        begin
                if d[v] then
                begin
                        dfs(v);
                        low[u]:=min(low[u],low[v]);
                end else
                        low[u]:=min(low[u],num[v]);
        end;
        if low[u]>=num[u] then
        repeat
                v:=q[r];dec(r);
                sh[v]:=num[u];
        until v=u;
end;

procedure dfs0(u:longint);
var     v:longint;
begin
        d[sh[u]]:=false;
        v:=ch[u];
        if sh[v]=sh[u] then f[sh[u]]:=sl[u] else
        if d[sh[v]] then
        begin
                dfs0(v);
                f[sh[u]]:=f[sh[v]]+1;
        end
        else f[sh[u]]:=f[sh[v]]+1;
end;

procedure main;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do readln(gi,ch[i]);

        cou:=0;r:=0;
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
                if num[i]=0 then dfs(i);

        fillchar(q,sizeof(q),0);
        for i:=1 to n do inc(q[sh[i]]);
        for i:=1 to n do sl[i]:=q[sh[i]];

        fillchar(d,sizeof(d),true);
        for i:=1 to n do
                if d[sh[i]] then dfs0(i);

        for i:=1 to n do writeln(go,f[sh[i]]);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
