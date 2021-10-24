Const   ginp='football.inp';
        gout='football.out';
        maxn=1001;

Type    edge= record x,y,link:longint; d:boolean; end;

Var     st,n,cr,ne,nheap:longint;
        rx,ry:array[0..maxn*maxn] of longint;
        a,head,deg,heap:array[0..maxn] of longint;
        e:array[-maxn*maxn..maxn*maxn] of edge;

Procedure Push(u:longint);
Var     i,j:longint;
Begin
        inc(nheap);
        heap[nheap]:=u;
        i:=nheap;
        while i>1 do
        begin
                j:=i div 2;
                if (deg[heap[j]]>=deg[u]) then break;
                heap[i]:=heap[j];
                i:=j;
        end;
        heap[i]:=u;
End;

Function Pop:longint;
Var     i,j,u:longint;
Begin
        pop:=heap[1];
        u:=heap[nheap]; dec(nheap);
        i:=1;
        while i*2<=nheap do
        begin
                j:=i*2;
                if (j<nheap) and (deg[heap[j+1]]>deg[heap[j]]) then inc(j);
                if (deg[heap[j]]<=deg[u]) then break;
                heap[i]:=heap[j];
                i:=j;
        end;
        heap[i]:=u;
End;

Procedure Add(i,u,v:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v; d:=true;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Dfs(u:longint);
Begin
        while head[u]<>0 do
        with e[head[u]] do
        begin
                if d then
                begin
                        dec(a[x]); dec(a[y]);
                        inc(cr);
                        rx[cr]:=x; ry[cr]:=y;
                        e[-head[u]].d:=false;
                        head[u]:=link;
                        dfs(y);
                        break;
                end;
                head[u]:=link;
        end;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
        readln;
End;

Procedure BuildGraph;
Var     i,j,u,v,top:longint;
        q:array[0..maxn] of longint;
Begin
        nheap:=0;
        for i:=1 to n do
        begin
                deg[i]:=a[i];
                if a[i]>0 then push(i);
        end;
        fillchar(head,sizeof(head),0);
        ne:=0;
        for i:=1 to n do
        begin
                if nheap=0 then exit;
                u:=pop; top:=0;
                for j:=1 to deg[u] do
                begin
                        if nheap=0 then exit;
                        v:=pop;
                        inc(top); q[top]:=v;
                        inc(ne);
                        add(ne,u,v); add(-ne,v,u);
                end;
                for j:=1 to top do
                begin
                        dec(deg[q[j]]);
                        if deg[q[j]]>0 then push(q[j]);
                end;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        cr:=0;
        for i:=1 to n do
                if a[i] mod 2=1 then dfs(i);
        for i:=1 to n do
                if a[i]>0 then
                begin
                        dfs(i);
                        if a[i]>0 then
                        begin
                                writeln(-1);
                                exit;
                        end;
                end;
        for i:=1 to cr do write(rx[i],' ',ry[i],' ');
        writeln;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                BuildGraph;
                Process;
        end;
        Close(input); Close(output);
End.
