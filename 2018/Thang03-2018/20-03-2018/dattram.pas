const   ginp='dattram.inp';
        gout='dattram.out';

var     gi,go:text;
        n,m,dem:longint;
        x,y,link:array[0..1111111] of longint;
        head,d:array[0..2222] of longint;

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
        d[u]:=dem;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if d[v]<>dem then dfs(v);
                i:=link[i];
        end;
end;

procedure process;
var     i:longint;
        dd:array[0..2222] of boolean;
begin
        fillchar(d,sizeof(d),0);
        dem:=0;
        for i:=1 to n do
                if d[i]=0 then
                begin
                        inc(dem);
                        dfs(i);
                end;
        dem:=0;
        fillchar(dd,sizeof(dd),true);
        for i:=1 to n do
                if dd[d[i]] then
                begin
                        inc(dem);
                        dd[d[i]]:=false;
                end;
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

