Const   ginp='tab.inp';
        gout='tab.out';
        maxn=1001;

Type    edge= record y,link,w:longint; end;

Var     n,cou:longint;
        ok:boolean;
        a,b,c:array[0..maxn,0..maxn] of longint;
        o1,o2:array[0..3*maxn] of longint;
        head,d:array[-maxn..maxn] of longint;
        e:array[-maxn*maxn..maxn*maxn] of edge;

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

Procedure Add(i,u,v,c:longint);
Begin
        with e[i] do
        begin
                y:=v; w:=c;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        if not ok then exit;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if d[y]=-1 then
                begin
                        if w=0 then d[y]:=d[u] else d[y]:=1-d[u];
                        dfs(y);
                end else
                if ((w=0) and (d[y]<>d[u])) or ((w=1) and (d[y]=d[u])) then ok:=false;
                i:=link;
        end;
End;

Function Check:boolean;
Var     i,j,m:longint;
Begin
        for i:=-n to n do head[i]:=0;
        m:=0;
        for i:=1 to n do
                for j:=1 to n do
                        if (a[i,j]=0)<>(b[i,j]=0) then exit(false) else
                        if (a[i,j]=0) and (b[i,j]=0) then continue else
                        if a[i,j]=b[i,j] then
                        begin
                                inc(m);
                                add(m,i,-j,0);
                                add(-m,-j,i,0);
                        end else
                        if a[i,j]<>b[i,j] then
                        begin
                                inc(m);
                                add(m,i,-j,1);
                                add(-m,-j,i,1);
                        end;
        for i:=-n to n do d[i]:=-1;
        ok:=true;
        for i:=-n to n do
                if (i<>0) and (d[i]=-1) then
                begin
                        d[i]:=0;
                        dfs(i);
                end;
        if not ok then exit(false) else check:=true;
        for i:=-n to -1 do
                if d[i]=1 then
                begin
                        inc(cou);
                        o1[cou]:=2; o2[cou]:=-i;
                end;
        for i:=1 to n do
                if d[i]=1 then
                begin
                        inc(cou);
                        o1[cou]:=1; o2[cou]:=i;
                end;
        writeln(cou);
        for i:=1 to cou do writeln(o1[i],' ',o2[i]);
End;

Procedure Process;
Var     i:longint;
Begin
        c:=a;
        cou:=0;
        if check then exit;
        a:=c;
        cou:=1; o1[1]:=3; o2[1]:=1;
        for i:=1 to n do a[i,i]:=-a[i,i];
        if check then exit;
        a:=c;
        cou:=1; o1[1]:=3; o2[1]:=2;
        for i:=1 to n do a[i,n-i+1]:=-a[i,n-i+1];
        if check then exit;
        a:=c;
        cou:=2; o1[1]:=3; o2[1]:=1; o1[2]:=3; o2[2]:=2;
        for i:=1 to n do a[i,i]:=-a[i,i];
        for i:=1 to n do a[i,n-i+1]:=-a[i,n-i+1];
        if check then exit;
        write(-1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
