Uses    Math;

Const   ginp='graph.inp';
        gout='graph.out';
        maxn=100010;
        maxm=200010;

Type    Edge= record x,y,link:longint; d:boolean; end;

Var     n,m,cou,res:longint;
        e:array[-maxm..maxm] of edge;
        head,pa,low,num:array[0..maxn] of longint;

Procedure Add(i,u,v:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v;
                link:=head[u]; d:=true;
        end;
        head[u]:=i;
End;

Procedure Dfs(u:longint);
var     i:longint;
Begin
        inc(cou); num[u]:=cou; low[u]:=cou;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if d then
                begin
                        e[-i].d:=false;
                        if num[y]=0 then
                        begin
                                pa[y]:=u;
                                dfs(y);
                                low[u]:=min(low[u],low[y]);
                        end else
                        begin
                                d:=false;
                                low[u]:=min(low[u],num[y]);
                        end;
                end;
                i:=link;
        end;
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
Var     u,i:longint;
Begin
        cou:=0; res:=0;
        for u:=1 to n do
                if num[u]=0 then
                begin
                        pa[u]:=-1;
                        inc(res);
                        dfs(u);
                end;
        for u:=1 to n do
        begin
                if pa[u]=-1 then cou:=-1 else cou:=0;
                i:=head[u];
                while i<>0 do
                with e[i] do
                begin
                        if (d) and (low[y]>=num[u]) then inc(cou);
                        i:=link;
                end;
                writeln(res+cou);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
