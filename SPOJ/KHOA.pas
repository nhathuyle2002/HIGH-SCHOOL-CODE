const   fi='KHOA.INP';
        fo='KHOA.OUT';
var     x,y,number,low,link,head,so:array[1..50000] of longint;
        q:array[1..10000000] of longint;
        dd,so2:array[1..50000] of boolean;
        m,n,kq,dem,c:longint;
        g:text;
procedure enter;
var i:longint;
begin
        assign(g,fi);
        reset(g);
        readln(g,n);
        for i:=1 to n do
        begin
                read(g,x[i]);
                y[i]:=i;
                link[i]:=head[x[i]];
                head[x[i]]:=i;
        end;
        close(g);
end;

procedure khoitao;
begin
        dem:=0; kq:=0;
        c:=1;
        q[1]:=0;
        fillchar(number,sizeof(number),0);
        fillchar(dd,sizeof(dd),true);
        fillchar(so2,sizeof(so2),true);
end;

function min(a,b:longint):longint;
begin
        if a>b then min:=b else min:=a;
end;

procedure tj(u:longint);
var  v:longint;
begin
        inc(dem);
        number[u]:=dem;
        low[u]:=maxlongint;
        inc(c);
        q[c]:=u;
        v:=head[u];
        while v<>0 do
        begin
                if dd[y[v]] then
                if number[y[v]]<>0 then low[u]:=min(low[u],number[y[v]])
                else
                begin
                        tj(y[v]);
                        low[u]:=min(low[u],low[y[v]]);
                end;
                v:=link[v];
        end;
        if low[u]>=number[u] then
        begin
        inc(kq);
        repeat
                v:=q[c];
                so[v]:=kq;
                dd[v]:=false;
                dec(c);
        until u=v;
        end;
end;


procedure xuli;
var  i,j:longint;
begin
        m:=n;
        for i:=1 to n do
        if dd[i] then tj(i);
        for i:=1 to m do
        begin
                if (so[x[i]]<>so[y[i]]) and (so2[so[y[i]]]) then
                begin
                        dec(kq);
                        so2[so[y[i]]]:=false;
                end;
        end;
end;


procedure xuat;
begin
        assign(g,fo);
        rewrite(g);
        writeln(g,kq);
        close(g);
end;

begin
        enter;
        khoitao;
        xuli;
        xuat;
end.
