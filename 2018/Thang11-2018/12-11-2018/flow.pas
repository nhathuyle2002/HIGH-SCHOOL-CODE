Uses    Math;

Const   ginp='flow.inp';
        gout='flow.out';
        maxm=100001;
        maxn=10001;
        oo=trunc(1e9)+100;

Type    edge=record x,y,w,link,f:longint; end;

Var     res:int64;
        n,m,start,finish:longint;
        e:array[-maxm..maxm] of edge;
        head,d,trace:array[0..maxn] of longint;

Procedure Add(i,u,v,c,fl:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v; w:=c;
                link:=head[u]; f:=fl;
        end;
        head[u]:=i;
End;

Procedure Enter;
Var     i,u,v,c:longint;
Begin
        readln(n,m,start,finish);
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c,0);
                add(-i,v,u,0,0);
        end;
End;

Function FindPath(s,t:longint):boolean;
VAr     i,l,r:longint;
        q:array[0..maxn] of longint;
Begin
        for i:=1 to n do trace[i]:=0;
        trace[s]:=-1; d[s]:=oo;
        l:=1; r:=1; q[1]:=s;
        repeat
                i:=head[q[l]]; inc(l);
                while i<>0 do
                with e[i] do
                begin
                        if (w-f>0) and (trace[y]=0) then
                        begin
                                trace[y]:=i;
                                d[y]:=min(d[x],w-f);
                                inc(r); q[r]:=y;
                        end;
                        i:=link;
                end;
        until (l>r) or (trace[t]<>0);
        if trace[t]=0 then exit(false) else exit(true);
End;

Procedure IncFlow(s,t:longint);
Var     i,incf,u:longint;
Begin
        incf:=d[t];
        u:=t;
        repeat
                i:=trace[u];
                inc(e[i].f,incf);
                dec(e[-i].f,incf);
                u:=e[i].x;
        until u=s;
End;

Procedure Process;
Var     i:longint;
Begin
        repeat
                if not FindPath(start,finish) then break;
                IncFlow(start,finish);
        until false;
        res:=0;
        i:=head[start];
        while i<>0 do
        with e[i] do
        begin
                res:=res+f;
                i:=link;
        end;
        writeln(res);
        for i:=1 to m do writeln(e[i].f);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
