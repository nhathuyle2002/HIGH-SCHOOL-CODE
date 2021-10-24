Uses    Math;

Const   ginp='rel.inp';
        gout='rel.out';
        maxn=100010;

Type    edge= record x,y,w,link:longint; end;

Var     n,na,m,below,top,count,cou:longint;
        e:array[-maxn..maxn] of edge;
        a,pos,stack,head,num,low:array[0..maxn] of longint;
        q,res,deg,id:array[0..maxn] of longint;

Procedure Add(i,u,v,c:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v; w:=c;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Swap(var u,v:longint);
Var     tmp:longint;
Begin
        tmp:=u; u:=v; v:=tmp;
End;

Procedure Push(u:longint);
Begin
        inc(top); q[top]:=u;
End;

Function Pop:longint;
Begin
        pop:=q[below]; inc(below);
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        inc(cou); num[u]:=cou; low[u]:=cou;
        inc(top); stack[top]:=u;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if w<>2 then
                begin
                        if num[y]=0 then
                        begin
                                dfs(y);
                                low[u]:=min(low[u],low[y]);
                        end else
                        if id[y]=0 then
                                low[u]:=min(low[u],num[y]);
                end;
                i:=link;
        end;
        if low[u]=num[u] then
        begin
                inc(count);
                pos[count]:=na+1;
                repeat
                        i:=stack[top]; dec(top);
                        id[i]:=count;
                        inc(na); a[na]:=i;
                until i=u;
        end;
End;

Procedure Enter;
Var     i,u,v:longint;
        s:string[4];
Begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(s);
                u:=ord(s[1])-48; delete(s,1,1);
                v:=ord(s[length(s)])-48; delete(s,length(s),1);
                if s='>=' then
                begin
                        swap(u,v);
                        s:='<=';
                end else
                if s='>' then
                begin
                        swap(u,v);
                        s:='<';
                end;
                if s='<' then add(i,u,v,2) else
                if s='<=' then add(i,u,v,1) else
                if s='=' then
                begin
                        add(i,u,v,0);
                        add(-i,v,u,0);
                end;
        end;
End;

Procedure Build;
Var     i:longint;
Begin
        count:=0; cou:=0; top:=0; na:=0;
        for i:=1 to n do
                if num[i]=0 then dfs(i);
        pos[count+1]:=n+1;
        for i:=1 to m do
        with e[i] do
                if id[x]<>id[y] then inc(deg[id[y]]);
End;

Procedure Process;
Var     i,ii,u,v:longint;
Begin
        below:=1; top:=0;
        for u:=1 to count do
        begin
                res[u]:=0;
                if deg[u]=0 then push(u);
        end;
        repeat
                u:=pop;
                for ii:=pos[u] to pos[u+1]-1 do
                begin
                        i:=head[a[ii]];
                        while i<>0 do
                        with e[i] do
                        begin
                                v:=id[y];
                                if v<>u then
                                begin
                                        if w=1 then res[v]:=max(res[v],res[u])
                                        else res[v]:=max(res[v],res[u]+1);
                                        dec(deg[v]);
                                        if deg[v]=0 then push(v);
                                end;
                                i:=link;
                        end;
                end;
        until below>top;
End;

Procedure Answer;
Var     i:longint;
Begin
        for i:=1 to n do write(res[id[i]],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Build;
        Process;
        Answer;
        Close(input); Close(output);
End.
