const   ginp='bridges.inp';
        gout='bridges.out';

var     gi,go:text;
        n,m,bri,cou:longint;
        y,link,x:array[-1001000..1001000] of longint;
        dc:array[-1001000..1001000] of boolean;
        head,num,low,pa:array[0..100100] of longint;

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

procedure swap(var xx,yy:longint);
var     tm:longint;
begin
        tm:=xx;
        xx:=yy;
        yy:=tm;
end;

procedure process;
var     i:longint;
begin
        fillchar(dc,sizeof(dc),true);
        for i:=1 to n do
                if pa[i]=0 then
                begin
                        pa[i]:=-1;
                        dfs(i);
                end;
        bri:=0;
        for i:=1 to n do
                if (pa[i]<>-1) and (low[i]>=num[i]) then
                begin
                        inc(bri);
                        x[bri]:=pa[i];
                        y[bri]:=i;
                        if x[bri]>y[bri] then swap(x[bri],y[bri]);
                end;
end;

procedure sort(l,r:longint);
var     i,j,tmx,tmy:longint;
begin
        if l>=r then exit;
        i:=random(r-l+1)+l;
        tmx:=x[i];tmy:=y[i];
        i:=l;j:=r;
        repeat
                while (x[i]<tmx) or ((x[i]=tmx) and (y[i]<tmy)) do inc(i);
                while (x[j]>tmx) or ((x[j]=tmx) and (y[j]>tmy)) do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);
                        swap(y[i],y[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure output;
var     i:longint;
begin
        writeln(go,bri);
        sort(1,bri);
        for i:=1 to bri do writeln(go,x[i],' ',y[i]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.

