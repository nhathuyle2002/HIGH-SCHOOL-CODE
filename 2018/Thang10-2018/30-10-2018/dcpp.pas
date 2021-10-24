Const   ginp='dcpp.inp';
        gout='dcpp.out';
        maxn=1001;
        maxm=10001;
        oo=trunc(1e9)+100;

Type    edge= record x,y,w,c,f,link:longint; end;

Var     n,m,nheap:longint;
        res:int64;
        e:array[-maxm..maxm] of edge;
        head,deg,pro:array[0..maxn] of longint;
        d,trace,heap,pos:array[0..maxn] of longint;

Procedure Add(i,u,v,ww,cc,ff:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v; w:=ww; c:=cc; f:=ff;
                link:=head[u];
        end;
        head[u]:=i;
End;

Function Update(u,x:longint):boolean;
Var     i,j:longint;
Begin
        if d[u]<=x then exit(false);
        d[u]:=x;
        if pos[u]=0 then
        begin
                inc(nheap);
                pos[u]:=nheap;
        end;
        i:=pos[u];
        while i>1 do
        begin
                j:=i shr 1;
                if d[heap[j]]<=x then break;
                heap[i]:=heap[j];
                pos[heap[i]]:=i;
                i:=j;
        end;
        heap[i]:=u;
        pos[u]:=i;
        update:=true;
End;

Function Pop:longint;
Var     i,j,u:longint;
Begin
        pop:=heap[1];
        u:=heap[nheap]; dec(nheap);
        i:=1;
        while i shl 1<=nheap do
        begin
                j:=i shl 1;
                if (j<nheap) and (d[heap[j+1]]<d[heap[j]]) then inc(j);
                if d[heap[j]]>=d[u] then break;
                heap[i]:=heap[j];
                pos[heap[i]]:=i;
                i:=j;
        end;
        heap[i]:=u;
        pos[u]:=i;
End;

Function Findpath(s:longint):longint;
Var     i,u,nz:longint;
        z:array[0..maxn] of longint;
Begin
        nheap:=0;
        filldword(pos[1],n,0);
        filldword(d[1],n,oo);
        update(s,0);
        nz:=0;
        repeat
                u:=pop;
                if deg[u]<0 then
                begin
                        findpath:=u;
                        break;
                end;
                inc(nz); z[nz]:=u;
                i:=head[u];
                while i<>0 do
                with e[i] do
                begin
                        if (c-f>0) and (update(y,d[u]+w+pro[u]-pro[y])) then trace[y]:=i;
                        i:=link;
                end;
        until false;
        for i:=1 to nz do inc(pro[z[i]],d[z[i]]-d[findpath]);
End;

Procedure Incflow(s,t:longint);
Var     i,incf,u:longint;
Begin
        if deg[s]<-deg[t] then incf:=deg[s] else incf:=-deg[t];
        u:=t;
        repeat
                i:=trace[u];
                inc(e[i].f,incf); dec(e[-i].f,incf);
                u:=e[i].x;
        until u=s;
        dec(deg[s],incf);
        inc(deg[t],incf);
End;

Procedure Enter;
Var     i,u,v,ww:longint;
Begin
        readln(n,m);
        filldword(deg[1],n,0);
        for i:=1 to m do
        begin
                readln(u,v,ww);
                add(i,u,v,ww,m,0);
                add(-i,v,u,ww,0,0);
                dec(deg[u]); inc(deg[v]);
        end;
End;

Procedure Process;
Var     i,u,t:longint;
Begin
        filldword(pro[1],n,0);
        for u:=1 to n do
        while deg[u]>0 do
        begin
                t:=findpath(u);
                incflow(u,t);
        end;
        res:=0;
        for i:=1 to m do res:=res+e[i].w;
        for i:=-m to m do
                if (i<>0) and (e[i].f>0) then res:=res+int64(e[i].f)*e[i].w;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
