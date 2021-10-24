Uses    Math;

Const   ginp='traffic.inp';
        gout='traffic.out';
        maxn=100010;
        maxm=200010;

Var     n,m,cou,sl,sl2,top,res,nn:longint;
        link,x,y:array[0..maxm] of longint;
        head,id,low,num,deg,st,root,leaf,pos,a,oux,ouy,id2:array[0..maxn] of longint;
        d:array[0..maxn] of boolean;

Procedure Dfs(u:longint);
Var     i,v:longint;
Begin
        inc(cou); num[u]:=cou; low[u]:=cou;
        inc(top); st[top]:=u;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if num[v]=0 then
                begin
                        dfs(v);
                        low[u]:=min(low[u],low[v]);
                end else
                if id[v]=0 then low[u]:=min(low[u],num[v]);
                i:=link[i];
        end;
        if low[u]=num[u] then
        begin
                inc(sl);
                pos[sl]:=nn+1;
                repeat
                        v:=st[top]; dec(top);
                        inc(nn); a[nn]:=v;
                        id[v]:=sl;
                until v=u;
        end;
End;

Procedure Dfstp(u:longint);
Var     i,ii,v,cou:longint;
Begin
        id2[u]:=sl2; cou:=0;
        for ii:=pos[u] to pos[u+1]-1 do
        begin
                i:=head[a[ii]];
                while i<>0 do
                begin
                        v:=id[y[i]];
                        if id2[v]=0 then dfstp(v) else
                        if leaf[sl2]=0 then leaf[sl2]:=leaf[id2[v]] else
                        begin
                                inc(res);
                                oux[res]:=leaf[id2[v]]; ouy[res]:=root[sl2];
                        end;
                        if v<>u then inc(cou);
                        i:=link[i];
                end;
        end;
        if cou=0 then
        begin
                if leaf[sl2]=0 then leaf[sl2]:=a[pos[u]] else
                begin
                        inc(res);
                        oux[res]:=a[pos[u]]; ouy[res]:=root[sl2];
                end;
        end;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(x[i],y[i]);
                link[i]:=head[x[i]];
                head[x[i]]:=i;
        end;
        cou:=0; top:=0; sl:=0; nn:=0;
        for i:=1 to n do
                if num[i]=0 then dfs(i);
        pos[sl+1]:=n+1;
End;

Procedure Process;
Var     i:longint;
Begin
        if sl=1 then
        begin
                write(0);
                exit;
        end;
        for i:=1 to m do
                if id[x[i]]<>id[y[i]] then inc(deg[id[y[i]]]);
        res:=0;
        for i:=1 to sl do
                if deg[i]=0 then
                begin
                        inc(sl2); root[sl2]:=a[pos[i]];
                        dfstp(i);
                end;
        root[sl2+1]:=root[1];
        for i:=1 to sl2 do
        begin
                inc(res);
                oux[res]:=leaf[i]; ouy[res]:=root[i+1];
        end;
        writeln(res);
        for i:=1 to res do writeln(oux[i],' ',ouy[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
