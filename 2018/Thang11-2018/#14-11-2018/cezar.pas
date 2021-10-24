Const   ginp='cezar.inp';
        gout='cezar.out';
        maxn=10010;

Type    edge= record x,y,link:longint; end;

Var     n,k,res:longint;
        e:array[-maxn..maxn] of edge;
        head,f,dep:array[0..maxn] of longint;

Procedure Add(i,u,v:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=f[random(r-l+1)+l];
        repeat
                while f[i]>t do inc(i);
                while t>f[j] do dec(j);
                if i<=j then
                begin
                        tmp:=f[i]; f[i]:=f[j]; f[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure DFS(u:longint);
Var     i:longint;
Begin
        f[u]:=1;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if dep[y]=0 then
                begin
                        dep[y]:=dep[u]+1;
                        dfs(y);
                        f[u]:=f[u]+f[y];
                end;
                i:=link;
        end;
End;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n,k);
        for i:=1 to n-1 do
        begin
                readln(u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
End;

Procedure Process;
Var     s,u,sum:longint;
Begin
        res:=maxn*maxn;
        for s:=1 to n do
        begin
                for u:=1 to n do dep[u]:=0;
                dep[s]:=1; dfs(s);
                sum:=0;
                for u:=1 to n do sum:=sum+dep[u]-1;
                f[s]:=0;
                sort(1,n);
                for u:=1 to k do sum:=sum-f[u];
                if sum<res then res:=sum;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
