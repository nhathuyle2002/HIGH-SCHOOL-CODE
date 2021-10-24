Const   ginp='cactus.inp';
        gout='cactus.out';
        maxn = 100001;
        maxm = 200001;

Type    edge = record x,y,link:longint; end;

Var     n,m:longint;
        e:array[-maxm..maxm] of edge;
        head:array[0..maxn] of longint;

Procedure Add(i,u,v:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
End;

Procedure Process;
Var     i,l,r:longint;
        q,d:array[0..maxn] of longint;

Function Bfs(s:longint):longint;
Var     i:longint;
Begin
        for i:=1 to n do d[i]:=0;
        d[s]:=1;
        l:=1; r:=1; q[1]:=s;
        repeat
                i:=head[q[l]];
                while i<>0 do
                with e[i] do
                begin
                        if d[y]=0 then
                        begin
                                d[y]:=d[x]+1;
                                inc(r); q[r]:=y;
                        end;
                        i:=link;
                end;
                inc(l);
        until l>r;
        bfs:=d[q[r]]-1;
End;

Begin
        for i:=1 to n do write(bfs(i),' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
