Const   ginp='ss.inp';
        gout='ss.out';
        maxn=200010;

Var     n:longint;
        res:int64;
        link,y:array[-maxn..maxn] of longint;
        head:array[0..maxn] of longint;
        child:array[0..maxn,0..1] of int64;

Procedure Add(i,u,v:longint);
Begin
        y[i]:=v;
        link[i]:=head[u];
        head[u]:=i;
End;

Procedure Dfs(u,pa,k:longint);
Var     i,v:longint;
Begin
        child[u,k]:=1; child[u,1-k]:=0;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if v<>pa then
                begin
                        dfs(v,u,1-k);
                        child[u,0]:=child[u,0]+child[v,0];
                        child[u,1]:=child[u,1]+child[v,1];
                end;
                i:=link[i];
        end;
        res:=res+int64(child[u,0]+child[u,1])*(n-child[u,0]-child[u,1]);
End;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n);
        for i:=1 to n-1 do
        begin
                readln(u,v);
                add(i,u,v); add(-i,v,u);
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        dfs(1,0,0);
        res:=res+int64(child[1,0])*child[1,1];
        write(res div 2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
