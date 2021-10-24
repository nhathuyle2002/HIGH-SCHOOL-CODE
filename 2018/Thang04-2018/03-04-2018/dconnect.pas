const   ginp='dconnect.inp';
        gout='dconnect.out';

var     gi,go:text;
        n,m,last,cou,ans:longint;
        link,y:array[-1000100..1000100] of longint;
        dc:array[-1000100..1000100] of boolean;
        head,low,num,pa,sta:array[0..100100] of longint;
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
                y[-i]:=u;link[-i]:=head[v];head[v]:=-i;
        end;
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
        push(u);
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if (dd[v]) and (dc[i]) then
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
        if low[u]>=num[u] then
        begin
                repeat
                        v:=pop;

                        dd[v]:=false;
                until v=u;
                inc(ans);
        end;
end;

procedure output;
var     i:longint;
begin
        fillchar(dd,sizeof(dd),true);
        fillchar(dc,sizeof(dc),true);
        for i:=1 to n do
                if pa[i]=0 then
                begin
                        pa[i]:=-1;
                        dfs(i);
                end;
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        output;
end.
