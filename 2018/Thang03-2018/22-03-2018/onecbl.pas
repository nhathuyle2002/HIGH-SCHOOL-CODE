const   ginp='onecbl.inp';
        gout='onecbl.out';

var     gi,go:text;
        ok:boolean;
        n,m,last,count,stp,dau,cuoi:longint;
        x,y:array[0..30001] of longint;
        d:array[0..2001,0..2001] of boolean;
        free:array[0..2001] of boolean;
        stack,low,num,tp:array[0..2001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        fillchar(d,sizeof(d),false);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,x[i],y[i]);
                d[x[i],y[i]]:=true;
        end;
end;

procedure push(u:longint);
begin
        inc(last);
        stack[last]:=u;
end;

function pop:longint;
begin
        pop:=stack[last];
        dec(last);
end;

function min(xx,yy:longint):longint;
begin
        if xx<yy then exit(xx) else exit(yy);
end;

procedure dfs(u:longint);
var     v:longint;
begin
        inc(count);num[u]:=count;low[u]:=count;
        push(u);
        for v:=1 to n do
                if (free[v]) and (d[u,v]) then
                begin
                        if num[v]<>0 then low[u]:=min(low[u],num[v])
                        else
                        begin
                                dfs(v);
                                low[u]:=min(low[u],low[v]);
                        end;
                end;
        if num[u]=low[u] then
        begin
                inc(stp);
                repeat
                        v:=pop;
                        tp[v]:=stp;
                        free[v]:=false;
                until v=u;
        end;
end;



procedure process;
var     i,dem1,dem2:longint;
        vao,ra:array[0..2001] of longint;
begin
        fillchar(free,sizeof(free),true);
        for i:=1 to n do
                if num[i]=0 then dfs(i);
        ok:=false;
        fillchar(vao,sizeof(vao),0);
        fillchar(ra,sizeof(ra),0);
        dem1:=0;dem2:=0;
        for i:=1 to m do
                if (tp[x[i]]<>tp[y[i]]) then
                begin
                        if ra[tp[x[i]]]=0 then
                        begin
                                ra[tp[x[i]]]:=1;
                                inc(dem1);
                        end;
                        if vao[tp[y[i]]]=0 then
                        begin
                                vao[tp[y[i]]]:=1;
                                inc(dem2);
                        end;
                end;
        if (dem1<>stp-1) or (dem2<>stp-1) then exit;
        ok:=true;
        for dau:=1 to n do
                if ra[tp[dau]]=0 then break;
        for cuoi:=1 to n do
                if vao[tp[cuoi]]=0 then break;
end;

procedure output;
begin
        if ok=false then write(go,'NO')
        else
        begin
                writeln(go,'YES');
                write(go,dau,' ',cuoi);
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
















