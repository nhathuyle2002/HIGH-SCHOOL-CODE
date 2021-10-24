const   ginp='hinge.inp';
        gout='hinge.out';

var     gi,go:text;
        n,m,joi,cou:longint;
        y,link:array[-1001000..1001000] of longint;
        dc:array[-1001000..1001000] of boolean;
        head,num,low,pa,xu:array[0..100100] of longint;

procedure input;
var     i,u,v:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,u,v);
                y[i]:=v;link[i]:=head[u];head[u]:=i;
                y[-i]:=u;link[-i]:=head[v];head[v]:=-i;
        end;
end;

function min(xx,yy:longint):longint;
begin
        if xx<yy then exit(xx) else exit(yy);
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        inc(cou);
        num[u]:=cou;
        low[u]:=maxlongint;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if dc[i] then
                begin
                        dc[-i]:=false;
                        if pa[v]<>0 then low[u]:=min(low[u],num[v])
                        else
                        begin
                                pa[v]:=u;
                                dfs(v);
                                low[u]:=min(low[u],low[v]);
                        end;
                end;
                i:=link[i];
        end;
end;

procedure process;
var     i,u,v:longint;
        chd:array[0..100100] of longint;
        dd:array[0..100100] of boolean;
begin
        fillchar(dc,sizeof(dc),true);
        for i:=1 to n do
                if pa[i]=0 then
                begin
                        pa[i]:=-1;
                        dfs(i);
                end;
        joi:=0;
        fillchar(chd,sizeof(chd),0);
        fillchar(dd,sizeof(dd),false);
        for i:=1 to n do
                if pa[i]<>-1 then inc(chd[pa[i]]);
        for v:=1 to n do
                if pa[v]<>-1 then
                begin
                        u:=pa[v];
                        if (low[v]>=num[u]) and ((pa[u]<>-1) or (chd[u]>=2)) then dd[u]:=true;
                end;
        for i:=1 to n do
                if dd[i] then
                begin
                        inc(joi);
                        xu[joi]:=i;
                end;
end;

procedure output;
var     i:longint;
begin
        writeln(go,joi);
        for i:=1 to joi do write(go,xu[i],' ');
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.

