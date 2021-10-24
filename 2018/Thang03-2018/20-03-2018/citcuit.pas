const   ginp='circuit.inp';
        gout='circuit.out';

var     gi,go:text;
        n,m,tmp:longint;
        link,x,y,head,pac,pad,d:array[0..100001] of longint;

procedure input;
var     i,u,v,dem:longint;
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

procedure output(v,u:longint);
var     dem,i:longint;
        trace:array[0..100001] of longint;
begin
        dem:=0;
        while v<>u do
        begin
                inc(dem);
                trace[dem]:=pac[v];
                v:=pad[v];
        end;
        inc(dem);
        trace[dem]:=pac[u];
        writeln(go,'YES');
        for i:=dem downto 1 do write(go,trace[i],' ');
        close(gi);close(go);
        halt;
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        d[u]:=tmp;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if d[v]=0 then
                begin
                        pac[v]:=i;
                        pad[v]:=u;
                        dfs(v);
                end
                else if d[v]=d[u] then
                begin
                        pac[v]:=i;
                        output(u,v);
                end;
                i:=link[i];
        end;
end;

procedure process;
var     i:longint;
begin
        for i:=1 to n do
                if d[i]=0 then
                begin
                        inc(tmp);
                        dfs(i);
                end;
end;

procedure output2;
begin
        write(go,'NO');
        close(gi);close(go);
end;

begin
        input;
        process;
        output2;
end.













