Const   ginp='cntab1.inp';
        gout='cntab1.out';
        maxn=51;

Type    edge= record x,y,w,link:longint; end;

Var     n:longint;
        a,b:array[0..maxn,0..maxn] of longint;
        head,d:array[-maxn..maxn] of longint;
        e:array[-maxn*maxn..maxn*maxn] of edge;
        ok:boolean;

Procedure Add(i,u,v,c:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v; w:=c;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if d[y]=-1 then
                begin
                        if w=1 then d[y]:=1-d[u] else d[y]:=d[u];
                        dfs(y);
                end else
                if ((w=0) and (d[y]<>d[u])) or ((w=1) and (d[y]=d[u])) then ok:=false;
                i:=link;
        end;
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
        for i:=1 to n do
        begin
                for j:=1 to n do read(b[i,j]);
                readln;
        end;
End;

Procedure Process;
Var     i,j,cou:longint;
Begin
        ok:=true;
        cou:=0;
        for i:=1 to n do
                for j:=1 to n do
                        if (a[i,j]=0)<>(b[i,j]=0) then ok:=false else
                        if (a[i,j]=0) or (b[i,j]=0) then continue else
                        if a[i,j]<>b[i,j] then
                        begin
                                inc(cou);
                                add(cou,i,-j,1);
                                add(-cou,-j,i,1);
                        end else
                        begin
                                inc(cou);
                                add(cou,i,-j,0);
                                add(-cou,-j,i,0);
                        end;
        for i:=-n to n do d[i]:=-1;
        d[0]:=0;
        for i:=-n to n do
                if d[i]=-1 then
                begin
                        d[i]:=0;
                        dfs(i);
                end;
        if not ok then write(-1) else
        begin
                cou:=0;
                for i:=-n to n do
                        if (i<>0) and (d[i]=1) then inc(cou);
                writeln(cou);
                for i:=1 to n do
                        if d[i]=1 then writeln(1,' ',i);
                for i:=-n to -1 do
                        if d[i]=1 then writeln(2,' ',-i);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
