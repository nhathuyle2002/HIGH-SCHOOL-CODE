Uses    Math;

Const   ginp='wedding.inp';
        gout='wedding.out';
        maxn=30001;

Type    edge= record y,link:longint; end;

Var     n,a,b,cou,res:longint;
        e:array[-maxn..maxn] of edge;
        head,pa,d,fa,fb,f,f1,f2:array[0..maxn] of longint;

Procedure Add(i,u,v:longint);
Begin
        with e[i] do
        begin
                y:=v; link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        if (u=a) or (u=b) then d[u]:=1;
        f[u]:=1;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if pa[y]=0 then
                begin
                        pa[y]:=u;
                        dfs(y);
                        if d[y]=0 then f[u]:=max(f[u],f[y]+1);
                        if d[y]=1 then d[u]:=1;
                end;
                i:=link;
        end;
End;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n);
        for i:=1 to n-1 do
        begin
                readln(u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
        read(a,b);
End;

Procedure Process;
Var     u,i:longint;
Begin
        for u:=1 to n do
        begin
                pa[u]:=0;
                d[u]:=0;
        end;
        pa[a]:=-1;
        dfs(a); fa:=f;
        for u:=1 to n do
        begin
                pa[u]:=0;
                d[u]:=0;
        end;
        pa[b]:=-1;
        dfs(b); fb:=f;
        u:=a; cou:=0;
        while u<>-1 do
        begin
                inc(cou);
                d[cou]:=u;
                u:=pa[u];
        end;
        f1[0]:=0;
        for i:=1 to cou do f1[i]:=max(f1[i-1],fa[d[i]]+i-1);
        f2[cou+1]:=0;
        for i:=cou downto 1 do f2[i]:=max(f2[i+1],fb[d[i]]+cou-i);
        res:=0;
        for i:=1 to cou-1 do res:=max(res,min(f1[i],f2[i+1]));
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
