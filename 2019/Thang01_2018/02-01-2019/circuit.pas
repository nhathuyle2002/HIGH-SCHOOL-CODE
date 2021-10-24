Uses    Math;

Const   ginp='circuit.inp';
        gout='circuit.out';
        maxn=100010;

Type    edge= record x,y,link:longint end;

Var     n,m,cou:longint;
        ok:boolean;
        e:array[0..maxn] of edge;
        head,d,trace,o:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        with e[i] do
        begin
                readln(x,y);
                link:=head[x];
                head[x]:=i;
        end;
End;

Procedure Truyvet(u,rr:longint);
Begin
        if u=rr then exit;
        inc(cou); o[cou]:=trace[u];
        truyvet(e[trace[u]].x,rr);
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        d[u]:=1;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if d[y]=0 then
                begin
                        trace[y]:=i;
                        dfs(y);
                end else
                if d[y]=1 then
                begin
                        cou:=1; o[1]:=i;
                        truyvet(u,y);
                        ok:=true;
                end;
                if ok then exit;
                i:=link;
        end;
        d[u]:=-1;
End;

Procedure Process;
Var     u:longint;
Begin
        for u:=1 to n do d[u]:=0;
        ok:=false; cou:=0;
        for u:=1 to n do
                if d[u]=0 then
                begin
                        dfs(u);
                        if ok then break;
                end;
        if not ok then writeln('NO') else
        begin
                writeln('YES');
                for u:=cou downto 1 do write(o[u],' ');
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
