Const   ginp='danang.inp';
        gout='danang.out';
        maxn=200010;
        oo=trunc(1e15);

Type    edge= record x,y,w,link:longint; end;

Var     n,m,delta:longint;
        e:array[-maxn..maxn] of edge;
        head:array[0..maxn] of longint;
        d:array[-maxn..maxn] of int64;
        nheap:longint;
        heap:array[0..2*maxn] of longint;
        pos:array[-maxn..maxn] of longint;

Procedure Add(i,u,v,c:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v; w:=c;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Enter;
Var     i,u,v,c:longint;
Begin
        readln(n,m,delta);
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
End;

Procedure Swap(var x,y:longint);
Var     tmp:longint;
Begin
        tmp:=x; x:=y; y:=tmp;
End;

Procedure Upheap(i:longint);
Var     j:longint;
Begin
        j:=i div 2;
        if j<1 then exit;
        if d[heap[i]]<d[heap[j]] then
        begin
                swap(pos[heap[i]],pos[heap[j]]);
                swap(heap[i],heap[j]);
                upheap(j);
        end;
End;

Procedure Update(u:longint; x:int64);
Begin
        if d[u]<=x then exit;
        d[u]:=x;
        if pos[u]=0 then
        begin
                inc(nheap);
                heap[nheap]:=u;
                pos[u]:=nheap;
        end;
        upheap(pos[u]);
End;

Procedure Downheap(i:longint);
Var     j:longint;
Begin
        j:=i*2;
        if j>nheap then exit;
        if (j<nheap) and (d[heap[j+1]]<d[heap[j]]) then inc(j);
        if d[heap[j]]<d[heap[i]] then
        begin
                swap(pos[heap[i]],pos[heap[j]]);
                swap(heap[i],heap[j]);
                downheap(j);
        end;
End;

Function Pop:longint;
Begin
        pop:=heap[1];
        swap(pos[heap[1]],pos[heap[nheap]]);
        swap(heap[1],heap[nheap]);
        dec(nheap);
        downheap(1);
End;

Function Dijkstra(s,t:longint):int64;
Var     i,u:longint;
Begin
        nheap:=0;
        for u:=-m to m do
        begin
                d[u]:=oo;
                pos[u]:=0;
        end;
        i:=head[s];
        while i<>0 do
        with e[i] do
        begin
                update(i,w);
                i:=link;
        end;
        repeat
                if nheap=0 then exit(-1);
                u:=pop;
                if e[u].y=t then exit(d[u]);
                i:=head[e[u].y];
                while i<>0 do
                with e[i] do
                begin
                        if (-u<>i) and (e[u].w+delta<=w) then update(i,d[u]+w);
                        i:=link;
                end;
        until false;
End;

Procedure Process;
Begin
        write(dijkstra(1,n));
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
