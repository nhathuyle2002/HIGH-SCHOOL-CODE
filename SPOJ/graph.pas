const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,dem,joint,bridge:longint;
        x,y,link:array[-50001..50001] of longint;
        d:array[-50001..50001] of boolean;
        head,low,pa,num,child:array[0..10001] of longint;
        dd:array[0..10001] of boolean;

procedure ad(i,u,v:longint);
begin
        x[i]:=u;
        y[i]:=v;
        link[i]:=head[u];
        head[u]:=i;
end;

procedure input;
var     i,u,v:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,u,v);
                ad(i,u,v);
                ad(-i,v,u);
        end;
end;

function min(xx,yy:longint):longint;
begin
        if xx<yy then exit(xx) else exit(yy);
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        inc(dem);
        low[u]:=maxlongint;
        num[u]:=dem;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if d[i] then
                begin
                        d[-i]:=false;
                        if pa[v]=0 then
                        begin
                                pa[v]:=u;
                                dfs(v);
                                low[u]:=min(low[u],low[v]);
                        end
                        else low[u]:=min(low[u],num[v]);
                end;
                i:=link[i];
        end;
end;

procedure process;
var     i,u,v:longint;
begin
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
                if pa[i]=0 then
                begin
                        pa[i]:=-1;
                        dfs(i);
                end;
        bridge:=0;joint:=0;
        for u:=1 to n do
                if (pa[u]<>-1) and (low[u]>=num[u]) then inc(bridge);
        for v:=1 to n do
                if pa[v]<>-1 then inc(child[pa[v]]);
        fillchar(dd,sizeof(dd),false);
        for v:=1 to n do
                if pa[v]<>-1 then
                begin
                        u:=pa[v];
                        if (low[v]>=num[u]) and ((pa[u]<>-1) or ((pa[u]=-1) and (child[u]>1))) then dd[u]:=true;
                end;
        for i:=1 to n do
                if dd[i] then inc(joint);
end;

procedure output;
begin
        write(go,joint,' ',bridge);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.











