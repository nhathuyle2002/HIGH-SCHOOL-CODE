const   ginp='dattram.inp';
        gout='dattram.out';

var     gi,go:text;
        n,m,dem,s:longint;
        x,y,link:array[0..1111111] of longint;
        head:array[0..2222] of longint;
        goc,d:array[0..2222] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,x[i],y[i]);
                link[i]:=head[x[i]];
                head[x[i]]:=i;
        end;
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        d[u]:=false;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if (goc[v]) and (v<>s) then goc[v]:=false;
                if d[v] then dfs(v);
                i:=link[i];
        end;
end;

procedure process;
var     i:longint;
begin
        fillchar(d,sizeof(d),true);
        fillchar(goc,sizeof(goc),false);
        for i:=1 to n do
                if d[i] then
                begin
                        s:=i;
                        goc[i]:=true;
                        dfs(i);
                end;
        dem:=0;
        for i:=1 to n do
                if goc[i] then inc(dem);
end;

procedure output;
begin
        write(go,dem);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
