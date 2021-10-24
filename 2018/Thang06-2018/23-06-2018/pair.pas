const   ginp='pair.inp';
        gout='pair.out';
        maxn=100010;

type    edge=record y,k:longint;end;

var     gi,go:text;
        n,k,cou:longint;
        res:int64;
        e:array[0..maxn] of edge;
        head,vl,vr:array[0..maxn] of longint;
        f:array[0..2*maxn] of longint;

procedure dfs(u:longint);
var     i,v:longint;
begin
        inc(cou);vl[u]:=cou;
        i:=head[u];
        while i<>0 do
        begin
                v:=e[i].y;
                dfs(v);
                i:=e[i].k;
        end;
        inc(cou);vr[u]:=cou;
end;

procedure input;
var     i,u,st:longint;
        d:array[0..maxn] of boolean;
begin
        readln(gi,n,k);
        fillchar(d,sizeof(d),true);
        for i:=1 to n-1 do
        begin
                readln(gi,u,e[i].y);
                d[e[i].y]:=false;
                e[i].k:=head[u];head[u]:=i;
        end;
        for i:=1 to n do
                if d[i] then st:=i;
        cou:=0;dfs(st);
end;

function get(i:longint):longint;
begin
        if i<1 then exit(0);
        get:=f[i]+get(i-i and (-i));
end;

procedure update(i,x:longint);
begin
        if i>2*n then exit;
        f[i]:=f[i]+x;
        update(i+i and (-i),x);
end;

procedure process;
var     i:longint;
begin
        if k>n then k:=n;
        res:=0;
        for i:=1 to k do update(vl[i],1);
        for i:=1 to n do
        begin
                if i+k<=n then update(vl[i+k],1);
                if i-k-1>0 then update(vl[i-k-1],-1);
                res:=res+get(vr[i])-get(vl[i]);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.










