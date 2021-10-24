const   ginp='connect.inp';
        gout='connect.out';

var     gi,go:text;
        n,m,last:longint;
        y,link:array[-1001000..1001000] of longint;
        head,sta:array[0..100100] of longint;
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
        dd[u]:=false;
        push(u);
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if dd[v] then dfs(v);
                i:=link[i];
        end;
end;

procedure output;
var     i,v:longint;
begin
        fillchar(dd,sizeof(dd),true);
        for i:=1 to n do
                if dd[i] then
                begin
                        dfs(i);
                        repeat
                                v:=pop;
                                write(go,v,' ');
                        until v=i;
                        writeln(go);
                end;
        close(gi);close(go);
end;

begin
        input;
        output;
end.

