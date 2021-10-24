Uses    Math;

Const   ginp='message.inp';
        gout='message.out';
        maxn=200001;

Type    edge= record x,y,link:longint; end;

Var     n,m,ctp,res:longint;
        e:array[0..maxn] of edge;
        head,id,deg,o:array[0..maxn] of longint;
        top,count:longint;
        q,num,low,d:array[0..maxn] of longint;
        a:array[0..maxn] of array of longint;

Procedure Add(i,u,v:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Dfs(u:longint);
Var     i,p:longint;
Begin
        d[u]:=1;
        inc(count);
        num[u]:=count; low[u]:=count;
        inc(top); q[top]:=u;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if d[y]=0 then
                begin
                        dfs(y);
                        low[u]:=min(low[u],low[y]);
                end else
                if id[y]=0 then
                        low[u]:=min(low[u],num[y]);
                i:=link;
        end;
        if low[u]=num[u] then
        begin
                inc(ctp);
                for p:=top downto 1 do
                        if q[p]=u then break;
                setlength(a[ctp],top-p+2);
                a[ctp,0]:=top-p+1;
                for i:=p to top do
                begin
                        a[ctp,i-p+1]:=q[i];
                        id[q[i]]:=ctp;
                end;
                top:=p-1;
        end;
End;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(u,v);
                add(i,u,v);
        end;
        count:=0; top:=0;
        for u:=1 to n do d[u]:=0;
        for u:=1 to n do
                if d[u]=0 then dfs(u);
End;

Procedure Process;
Var     u,i:longint;
Begin
        for i:=1 to m do
        with e[i] do
                if id[x]<>id[y] then inc(deg[id[y]]);
        res:=0;
        for u:=1 to ctp do
                if deg[u]=0 then
                begin
                        inc(res);
                        o[res]:=a[u,1];
                end;
        writeln(res);
        for i:=1 to res do write(o[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
