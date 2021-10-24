Uses    Math;

Const   ginp='dea.inp';
        gout='dea.out';
        maxn=1010;
        maxm=20010;
        oo=trunc(1e9)+100;

Type    edge= record x,y,link,w,f:longint; end;

Var     n,m:longint;
        res:int64;
        e:array[-maxm..maxm] of edge;
        head,d,trace:array[0..maxn] of longint;

Procedure Add(i,u,v,c:longint);
Begin
        with e[i] do
        begin
                x:=u; y:=v; w:=c; f:=0;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Enter;
Var     i,u,v,c:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c); add(-i,v,u,0);
                add(i+m,v,u,c); add(-i-m,u,v,0);
        end;
End;

Function FindPath(s,t,typ:longint):boolean;
Var     i,u,l,r:longint;
        q:array[0..maxn] of longint;
Begin
        for u:=1 to n do trace[u]:=0;
        l:=1; r:=1; q[1]:=s; d[s]:=oo; trace[s]:=oo;
        repeat
                u:=q[l]; inc(l);
                i:=head[u];
                while i<>0 do
                with e[i] do
                begin
                        if trace[y]=0 then
                        begin
                                if (i>0) and (w-f>0) then
                                begin
                                        trace[y]:=i;
                                        d[y]:=min(d[u],w-f);
                                end else
                                if (i<0) and (e[-i].f>0) then
                                begin
                                        trace[y]:=i;
                                        d[y]:=min(d[u],e[-i].f);
                                end;
                                if trace[y]<>0 then
                                begin
                                        if (y=t) and (typ=1) then exit(true);
                                        inc(r); q[r]:=y;
                                end;
                        end;
                        i:=link;
                end;
        until l>r;
        findpath:=false;
End;

Procedure IncFlow(s,t:longint);
Var     i,u,incf:longint;
Begin
        u:=t; incf:=d[t];
        repeat
                i:=trace[u];
                if i>0 then e[i].f:=e[i].f+incf else e[-i].f:=e[-i].f-incf;
                u:=e[i].x;
        until u=s;
End;

Procedure MinCut;
Var     i,cou:longint;
        ou:array[0..maxm] of longint;
Begin
        res:=0; cou:=0;
        findpath(n,1,0);
        for i:=1 to m do
        with e[i] do
                if (trace[x]<>0) and (trace[y]=0) then
                begin
                        inc(cou); ou[cou]:=i;
                        res:=res+e[i].w;
                end;
        writeln(res);
        for i:=1 to cou do write(ou[i],' ');
End;

Procedure Process;
Begin
        repeat
                if not findpath(n,1,1) then break;
                incflow(n,1);
        until false;
        mincut;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.

