Const   ginp='hyvong.inp';
        gout='hyvong.out';
        maxn=460;
        maxm=1200;
        oo=trunc(1e15);

Type    edge= record y,link,w,typ:longint; end;
        save= record u,j1,j2:longint; w:int64; end;

Var     n,m,k1,k2,start,finish:longint;
        head:array[0..maxn] of longint;
        e:array[-maxm..maxm] of edge;
        d:array of array of array of int64;
        pos:array of array of array of longint;
        //d,pos:array[1..4,0..1,0..1] of longint;
        nheap:longint;
        heap:array[0..maxn*maxm] of save;

Procedure Enter;
Var     i,j,u,v,c,t:longint;

        Procedure Add(i,u,v,c,t:longint);
        Begin
                with e[i] do
                begin
                        y:=v; w:=c; typ:=t;
                        link:=head[u];
                end;
                head[u]:=i;
        End;

Begin
        readln(n,m,k1,k2);
        for i:=1 to m do
        begin
                readln(u,v,c,t);
                add(i,u,v,c,t);
                add(-i,v,u,c,t);
        end;
        read(start,finish);
End;

Procedure Init;
Var     i,j1,j2:longint;
Begin
        setlength(d,n+1);
        setlength(pos,n+1);
        for i:=1 to n do
        begin
                setlength(d[i],k1+1);
                setlength(pos[i],k1+1);
                for j1:=0 to k1 do
                begin
                        setlength(d[i,j1],k2+1);
                        setlength(pos[i,j1],k2+1);
                        for j2:=0 to k2 do
                        begin
                                d[i,j1,j2]:=oo;
                                pos[i,j1,j2]:=0;
                        end;
                end;
        end;
        {for i:=1 to n do
                for j1:=0 to k1 do
                        for j2:=0 to k2 do
                        begin
                                d[i,j1,j2]:=oo;
                                pos[i,j1,j2]:=0;
                        end;}
End;

Procedure Update(u,j1,j2:longint; w:int64);
Var     i,j:longint;
        p:save;
Begin
        if (j1>k1) or (j2>k2) or (d[u,j1,j2]<=w) then exit;
        d[u,j1,j2]:=w;
        if pos[u,j1,j2]=0 then
        begin
                inc(nheap);
                pos[u,j1,j2]:=nheap;
        end;
        p.u:=u; p.j1:=j1; p.j2:=j2; p.w:=w;
        i:=pos[u,j1,j2];
        while i>1 do
        begin
                j:=i shr 1;
                if heap[j].w<=p.w then break;
                heap[i]:=heap[j];
                i:=j;
        end;
        pos[u,j1,j2]:=i;
        heap[i]:=p;
End;

Function Pop:save;
Var     i,j:longint;
        p:save;
Begin
        pop:=heap[1];
        p:=heap[nheap]; dec(nheap);
        i:=1;
        while i*2<=nheap do
        begin
                j:=i*2;
                if (j<nheap) and (heap[j+1].w<heap[j].w) then inc(j);
                if heap[j].w>=p.w then break;
                heap[i]:=heap[j];
                i:=j;
        end;
        pos[p.u,p.j1,p.j2]:=i;
        heap[i]:=p;
End;

Procedure Process;
Var     i:longint;
        p:save;
Begin
        nheap:=0;
        update(start,0,0,0);
        repeat
                if nheap=0 then break;
                p:=pop;
                if (p.u=finish) and (p.j1=k1) and (p.j2=k2) then break;
                with p do
                begin
                        i:=head[u];
                        while i<>0 do
                        begin
                                if e[i].typ=0 then update(e[i].y,j1,j2,w+e[i].w) else
                                if e[i].typ=1 then update(e[i].y,j1+1,j2,w+e[i].w) else
                                if e[i].typ=2 then update(e[i].y,j1,j2+1,w+e[i].w);
                                i:=e[i].link;
                        end;
                end;
        until false;
        if d[finish,k1,k2]=oo then write(-1) else write(d[finish,k1,k2]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        Process;
        Close(input); Close(output);
End.
