Uses    Math;

Const   ginp='cirarc.inp';
        gout='cirarc.out';
        maxn=200010;

Type    edge= record x,y,link:longint end;

Var     n,m,res,id:longint;
        ok:boolean;
        e,o:array[0..maxn] of edge;
        top,cou:longint;
        head,num,low,pa,q,d:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t,tmp:edge;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=o[random(r-l+1)+l];
        repeat
                while (o[i].x<t.x) or ((o[i].x=t.x) and (o[i].y<t.y)) do inc(i);
                while (o[j].x>t.x) or ((o[j].x=t.x) and (o[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        tmp:=o[i]; o[i]:=o[j]; o[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        with e[i] do
        begin
                readln(x,y);
                link:=head[x];
                head[x]:=i;
        end;
End;

{Procedure Dfs(u:longint);
Var     i,c:longint;
Begin
        d[u]:=1;
        inc(cou); num[u]:=cou; low[u]:=cou;
        inc(top); q[top]:=u;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if i<>id then
                begin
                        if d[y]=0 then
                        begin
                                dfs(y);
                                low[u]:=min(low[u],low[y]);
                        end else
                        if d[y]=1 then
                                low[u]:=min(low[u],num[y]);
                end;
                i:=link;
        end;
        if low[u]=num[u] then
        begin
                c:=0;
                repeat
                        i:=q[top];
                        d[i]:=-1;
                        dec(top); inc(c);
                until i=u;
                if c>=2 then ok:=true;
        end;
End;}

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        d[u]:=1;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if i<>id then
                begin
                        if d[y]=0 then dfs(y) else
                        if d[y]=1 then ok:=true;
                end;
                if ok then exit;
                i:=link;
        end;
        d[u]:=-1;
End;

Procedure Process;
Var     i,u:longint;
Begin
        res:=0;
        for i:=1 to m do
        begin
                ok:=false;
                for u:=1 to n do d[u]:=0;
                id:=i;
                for u:=1 to n do
                        if d[u]=0 then
                        begin
                                dfs(u);
                                if ok then break;
                        end;
                if not ok then
                begin
                        inc(res);
                        o[res]:=e[i];
                end;
        end;
        sort(1,res);
        writeln(res);
        for i:=1 to res do writeln(o[i].x,' ',o[i].y);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
