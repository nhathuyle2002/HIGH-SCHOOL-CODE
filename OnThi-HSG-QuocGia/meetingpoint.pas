 Uses    Math;

Const   ginp='meetingpoint.inp';
        gout='meetingpoint.out';
        maxn=100001;
        maxm=200001;
        oo=trunc(1e13);

Type    edge= record y,w,link:longint; end;

Var     n,m,k,n0:longint;
        e:array[-maxm..maxm] of edge;
        head:array[0..maxn] of longint;
        nheap:longint;
        heap,pos:array[0..maxn] of longint;
        d1,dn:array[0..maxn] of int64;

Procedure Add(i,u,v,c:longint);
Begin
        with e[i] do
        begin
                y:=v; w:=c;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Enter;
Var     i,u,v,c:longint;
Begin
        readln(n,m,k);
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
End;

Procedure Update(u:longint;x:int64);
Var     i,j:longint;
Begin
        if x>=d1[u] then exit;
        d1[u]:=x;
        if pos[u]=0 then
        begin
                inc(nheap);
                pos[u]:=nheap;
        end;
        i:=pos[u];
        while i>1 do
        begin
                j:=i shr 1;
                if (d1[heap[j]]<=x) then break;
                pos[heap[j]]:=i;
                heap[i]:=heap[j];
                i:=j;
        end;
        pos[u]:=i;
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
                if (j<nheap) and (d1[heap[j+1]]<d1[heap[j]]) then inc(j);
                if (d1[heap[j]]>=d1[u]) then break;
                pos[heap[j]]:=i;
                heap[i]:=heap[j];
                i:=j;
        end;
        pos[u]:=i;
        heap[i]:=u;
End;

Procedure Dijkstra(s:longint);
Var     i,u:longint;
Begin
        nheap:=0;
        for u:=1 to n do
        begin
                d1[u]:=oo;
                pos[u]:=0;
        end;
        update(s,0);
        repeat
                if nheap=0 then break;
                u:=pop;
                i:=head[u];
                while i<>0 do
                with e[i] do
                begin
                        update(y,d1[u]+w);
                        i:=link;
                end;
        until false;
End;

Procedure Sort(l,r:longint);
Var     i,j,t:longint;
        t1,tn,tmp:int64;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=random(r-l+1)+l;
        tn:=dn[t]; t1:=d1[t];
        repeat
                while (d1[i]<t1) or ((d1[i]=t1) and (dn[i]<tn)) do inc(i);
                while (d1[j]>t1) or ((d1[j]=t1) and (dn[j]>tn)) do dec(j);
                if i<=j then
                begin
                        tmp:=d1[i]; d1[i]:=d1[j]; d1[j]:=tmp;
                        tmp:=dn[i]; dn[i]:=dn[j]; dn[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Process;
Var     i,a,b,l,r,mid:longint;
Begin
        dijkstra(n); dn:=d1;
        dijkstra(1);
        sort(1,n);
        n0:=0; d1[0]:=0; dn[0]:=oo;
        for i:=1 to n do
                if (d1[i]=oo) or (dn[i]=oo) then continue else
                if (dn[i]<dn[n0]) then
                begin
                        inc(n0);
                        d1[n0]:=d1[i]; dn[n0]:=dn[i];
                end;
        for k:=1 to k do
        begin
                readln(a,b);
                l:=1; r:=n0+1;
                while l<r do
                begin
                        mid:=(l+r) shr 1;
                        if d1[mid]*a<dn[mid]*b then l:=mid+1 else r:=mid;
                end;
                if r>n0 then writeln(dn[r-1]*b) else writeln(min(dn[r-1]*b,d1[r]*a));
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
