Const   ginp='netsrv.inp';
        gout='netsrv.out';
        maxn=500;//150001;

Type    edge= record y,link,w:longint; end;

Var     st,n,m,res:longint;
        head1:array[0..maxn] of longint;
        e1:array[-maxn..maxn] of edge;
        {head2:array[0..maxn] of longint;
        e2:array[-maxn..maxn] of edge;}
        w:array[0..maxn,0..maxn] of longint;
        cou:longint;
        d,trace:array[0..maxn] of longint;

Procedure Enter;
Var     i,u,v,c:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                head1[i]:=0;
                //head2[i]:=0;
        end;
        for i:=1 to n-1 do
        begin
                readln(u,v);
                with e1[i] do
                begin
                        y:=v; link:=head1[u];
                        head1[u]:=i;
                end;
                with e1[-i] do
                begin
                        y:=u; link:=head1[v];
                        head1[v]:=-i;
                end;
        end;
        {readln(m);
        for i:=1 to m do
        begin
                readln(u,v,c);
                with e2[i] do
                begin
                        y:=v; w:=c; link:=head2[u];
                end;
                with e2[-i] do
                begin
                        y:=u; w:=c; link:=head2[v];
                end;
        end;}
        readln(m);
        for u:=1 to n do
                for v:=1 to n do w[u,v]:=0;
        for i:=1 to m do
        begin
                readln(u,v,c);
                w[u,v]:=c; w[v,u]:=c;
        end;
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        i:=head1[u];
        while i<>0 do
        with e1[i] do
        begin
                if trace[y]=0 then
                begin
                        trace[y]:=u;
                        dfs(y);
                end;
                i:=link;
        end;
End;

Procedure Process;
Var     a,b,u,sum:longint;
Begin
        res:=0;
        for a:=1 to n do
        begin
                for u:=1 to n do trace[u]:=0;
                trace[a]:=-1; dfs(a);
        for b:=a+1 to n do
        begin
                for u:=1 to n do d[u]:=0;
                u:=b;
                while u<>-1 do
                begin
                        d[u]:=1;
                        u:=trace[u];
                end;
                sum:=0;
                for u:=1 to n do
                        if d[u]=1 then sum:=sum+w[a,u]+w[b,u];
                sum:=sum-w[a,b];
                if sum>res then res:=sum;
        end;
        end;
        writeln(res);
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
