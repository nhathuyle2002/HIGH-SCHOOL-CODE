Uses    Math;

Const   ginp='tmaxset.inp';
        gout='tmaxset.out';
        maxn = 201;

Type    edge = record y,link:longint; end;

Var     st,n,q,res,k,m:longint;
        head:array[0..maxn] of longint;
        e:array[-maxn..maxn] of edge;
        a:array[0..maxn] of int64;
        d:array[0..maxn] of boolean;
        f:array[0..maxn,0..1] of int64;

Procedure Add(i,u,v:longint);
Begin
        with e[i] do
        begin
                y:=v; link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n,m);
        for i:=0 to n-1 do
        begin
                read(a[i]);
                head[i]:=0;
        end;
        readln;
        for i:=1 to m do
        begin
                readln(u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
        readln(q);
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        d[u]:=false;
        f[u,0]:=0; f[u,1]:=a[u];
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if d[y] then
                begin
                        dfs(y);
                        f[u,0]:=f[u,0]+max(f[y,0],f[y,1]);
                        f[u,1]:=f[u,1]+f[y,0];
                end;
                i:=link;
        end;
End;

Procedure Process;
Var     i,x:longint;
Begin
        for q:=1 to q do
        begin
                for i:=0 to n-1 do d[i]:=false;
                read(k);
                for i:=1 to k do
                begin
                        read(x);
                        d[x]:=true;
                end;
                readln;
                res:=0;
                for i:=0 to n-1 do
                        if d[i] then
                        begin
                                dfs(i);
                                res:=res+max(f[i,0],f[i,1]);
                        end;
                writeln(res);
        end;
        writeln;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                Process;
        end;
        Close(input); Close(output);
End.
