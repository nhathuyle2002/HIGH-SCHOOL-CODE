Uses    Math;

Const   ginp='sperfect.inp';
        gout='sperfect.out';
        maxn=100010;

Var     n,m,stp,top,cou,qq:longint;
        res:boolean;
        exist:array[0..maxn] of boolean;
        link,x,y:array[0..maxn] of longint;
        head,id,deg,num,low,st,a,l:array[0..maxn] of longint;

Procedure Dfs(u:longint);
Var     i,v:longint;
Begin
        inc(cou); num[u]:=cou; low[u]:=cou;
        inc(top); st[top]:=u;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if id[v]=0 then
                begin
                        if num[v]=0 then
                        begin
                                dfs(v);
                                low[u]:=min(low[u],low[v]);
                        end else
                                low[u]:=min(low[u],num[v]);
                end;
                i:=link[i];
        end;
        if low[u]=num[u] then
        begin
                inc(stp);
                repeat
                        v:=st[top]; dec(top);
                        id[v]:=stp;
                until v=u;
        end;
End;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=id[a[random(r-l+1)+l]];
        repeat
                while id[a[i]]<t do inc(i);
                while id[a[j]]>t do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        inc(n);
        for i:=1 to n do
        begin
                exist[i]:=false;
                head[i]:=0;
        end;
        for i:=1 to m do
        begin
                readln(x[i],y[i]);
                link[i]:=head[x[i]];
                head[x[i]]:=i;
                exist[x[i]]:=true; exist[y[i]]:=true;
        end;
End;

Procedure Graph;
Var     i:longint;
Begin
        stp:=0; cou:=0; top:=0;
        for i:=1 to n do
        begin
                num[i]:=0; id[i]:=0;
                a[i]:=i;
        end;
        for i:=1 to n do
                if (exist[i]) and (num[i]=0) then dfs(i);
        for i:=1 to n do
                if not exist[i] then id[i]:=stp+1;
        sort(1,n);
        a[0]:=0; id[a[0]]:=0;
        for i:=1 to n do
        begin
                if id[a[i]]>id[a[i-1]] then l[id[a[i]]]:=i;
                if id[a[i]]=stp+1 then break;
        end;
        for i:=1 to stp do deg[i]:=0;
End;

Procedure Process;
Var     i,v,u,ii,uu:longint;
Begin
        for i:=1 to m do
                if id[x[i]]<>id[y[i]] then inc(deg[id[y[i]]]);
        cou:=0;
        for i:=1 to stp do
                if deg[i]=0 then
                begin
                        inc(cou); u:=i;
                end;
        res:=true;
        repeat
                if cou>1 then
                begin
                        res:=false;
                        break;
                end;
                cou:=0; uu:=0;
                for ii:=l[u] to l[u+1]-1 do
                begin
                        i:=head[a[ii]];
                        while i<>0 do
                        begin
                                v:=id[y[i]];
                                if v<>u then
                                begin
                                        dec(deg[v]);
                                        if deg[v]=0 then
                                        begin
                                                inc(cou); uu:=v;
                                        end
                                end;
                                i:=link[i];
                        end;
                end;
                u:=uu;
        until u=0;
        if res then writeln('YES') else writeln('NO');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(qq);
        while qq>0 do
        begin
                Enter;
                Graph;
                Process;
                dec(qq);
        end;
        Close(input); Close(output);
End.
