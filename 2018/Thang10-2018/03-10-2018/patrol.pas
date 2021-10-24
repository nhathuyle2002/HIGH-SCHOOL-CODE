Const   ginp='patrol.inp';
        gout='patrol.out';
        maxm=100010;
        maxn=1001;

Var     n,m,res,cou,top,sltp:longint;
        link,y:array[0..maxm] of longint;
        head,low,num,deg,root,st:array[0..maxn] of longint;
        tp,ch:array[0..maxn,0..maxn] of longint;
        dd:array[0..maxn] of boolean;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(x,y[i]);
                link[i]:=head[x];
                head[x]:=i;
        end;
End;

Function Min(x,y:longint):longint;
Begin
        if x<y then min:=x else min:=y;
End;

Procedure Dfs(u:longint);
Var     i,v:longint;
Begin
        dd[u]:=false;
        inc(top); st[top]:=u;
        inc(cou); num[u]:=cou; low[u]:=cou;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if dd[v] then
                begin
                        dfs(v);
                        low[u]:=min(low[u],low[v]);
                end else
                if root[v]=0 then
                        low[u]:=min(low[u],num[v]);
                i:=link[i];
        end;
        if low[u]=num[u] then
        begin
                inc(sltp);
                repeat
                        v:=st[top]; root[v]:=sltp;
                        inc(tp[sltp,0]); tp[sltp,tp[sltp,0]]:=v;
                        dec(top);
                until v=u;
        end;
End;

Procedure Dfs2(u:longint);
Var     i,v,ii,j:longint;
        put:array[0..maxn] of boolean;
Begin
        dd[u]:=false;
        ch[u,0]:=1; ch[u,1]:=u;
        fillchar(put,sizeof(put),true);
        for ii:=1 to tp[u,0] do
        begin
                i:=head[tp[u,ii]];
                while i<>0 do
                begin
                        v:=root[y[i]];
                        if v<>u then
                        begin
                                if dd[v] then dfs2(v);
                                inc(deg[u]);
                                for j:=1 to ch[v,0] do
                                        if deg[ch[v,j]]>0 then
                                        begin
                                                dec(deg[ch[v,j]]);
                                                break;
                                        end;
                                for j:=1 to ch[v,0] do
                                        if put[ch[v,j]] then
                                        begin
                                                inc(ch[u,0]); ch[u,ch[u,0]]:=ch[v,j];
                                                put[ch[v,j]]:=false;
                                        end;
                        end;
                        i:=link[i];
                end;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        fillchar(dd,sizeof(dd),true);
        cou:=0; top:=0; sltp:=0;
        dfs(1);
        fillchar(deg,sizeof(deg),0);
        fillchar(dd,sizeof(dd),true);
        dfs2(root[1]);
        res:=0;
        for i:=1 to sltp do
                if deg[i]>0 then res:=res+deg[i];
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
