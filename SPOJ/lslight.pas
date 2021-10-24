const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,m,cou,ans:longint;
        link,x,y:array[0..100000] of longint;
        head,ou:array[0..500] of longint;
        d:array[0..500] of boolean;

procedure input;
var     i,j,xx:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        m:=0;
        readln(gi,n);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(gi,xx);
                        if (xx=1) and (i<>j) then
                        begin
                                inc(m);
                                x[m]:=i;y[m]:=j;
                                link[m]:=head[i];head[i]:=m;
                        end;
                end;
                readln(gi);
        end;
end;

procedure dfs(u:longint);
var     i,v:longint;
begin
        inc(cou);
        d[u]:=false;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if d[v] then dfs(v);
                i:=link[i];
        end;
end;

procedure process;
var     i:longint;
begin
        for i:=1 to n do
        begin
                fillchar(d,sizeof(d),true);
                cou:=0;dfs(i);
                if cou=n then
                begin
                        inc(ans);
                        ou[ans]:=i;
                end;
        end;
end;

procedure output;
var     i:longint;
begin
        writeln(go,ans);
        for i:=1 to ans do writeln(go,ou[i]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
