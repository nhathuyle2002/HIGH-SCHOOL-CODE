const   ginp='sconnect.inp';
        gout='sconnect.out';

var     gi,go:text;
        n,m,cou,last:longint;
        y,link,x:array[0..1001000] of longint;
        head,num,low,sta:array[0..100100] of longint;
        dd:array[0..100100] of boolean;

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
        end;
end;

function min(xx,yy:longint):longint;
begin
        if xx<yy then exit(xx) else exit(yy);
end;

procedure push(u:longint);
begin
        inc(last);
        sta[last]:=u;
end;

function pop:longint;
begin
        pop:=sta[last];
        dec(last);
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        inc(cou);
        num[u]:=cou;
        push(u);
        low[u]:=cou;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if (dd[v]) then
                begin
                        if num[v]<>0 then low[u]:=min(low[u],num[v])
                        else
                        begin
                                dfs(v);
                                low[u]:=min(low[u],low[v]);
                        end;
                end;
                i:=link[i];
        end;
        if low[u]=num[u] then
        begin
                repeat
                        v:=pop;
                        write(go,v,' ');
                        dd[v]:=false;
                until v=u;
                writeln(go);
        end;
end;

procedure output;
var     i:longint;
begin
        fillchar(dd,sizeof(dd),true);
        for i:=1 to n do
                if num[i]=0 then dfs(i);
        close(gi);close(go);
end;

begin
        input;
        output;
end.

