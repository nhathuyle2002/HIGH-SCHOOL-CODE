Uses    Math;

Const   ginp='dea.inp';
        gout='dea.out';
        maxn=1010;
        maxm=10010;
        oo=trunc(1e9)+100;

Type    edge= record x,y,link,w,f:longint; end;

Var     n,m,s,t:longint;
        res:int64;
        head:array[0..maxn] of longint;
        e:array[-maxm*2..maxm*2] of edge;
        l,r:longint;
        d,trace,q:array[0..maxn] of longint;

Procedure Add(i,u,v,c,ff:longint); inline;
Begin
        with e[i] do
        begin
                x:=u; y:=v; w:=c; f:=ff;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Enter;
Var     i,u,v,c:longint;
Begin
        readln(n,m); s:=1; t:=n;
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c,0);
                add(-i,v,u,0,0);
                add(i+m,v,u,c,0);
                add(-i-m,u,v,0,0);
        end;
End;

Function FindPath:boolean; inline;
Var     u,i:longint;
Begin
        for u:=1 to n do trace[u]:=0;
        d[s]:=oo; trace[s]:=-1;
        l:=1; r:=1; q[1]:=s;
        repeat
                u:=q[l]; inc(l);
                i:=head[u];
                while i<>0 do
                with e[i] do
                begin
                        if (trace[y]=0) and (w-f>0) then
                        begin
                                trace[y]:=i;
                                d[y]:=min(d[u],w-f);
                                if y=t then exit(true);
                                inc(r); q[r]:=y;
                        end;
                        i:=link;
                end;
        until l>r;
        findpath:=false;
End;

Procedure FindPath2; inline;
Var     u,i:longint;
Begin
        for u:=1 to n do trace[u]:=0;
        trace[s]:=-1;
        l:=1; r:=1; q[1]:=s;
        repeat
                u:=q[l]; inc(l);
                i:=head[u];
                while i<>0 do
                with e[i] do
                begin
                        if (trace[y]=0) and (w-f>0) then
                        begin
                                trace[y]:=i;
                                inc(r); q[r]:=y;
                        end;
                        i:=link;
                end;
        until l>r;
End;

Procedure IncFlow; inline;
Var     u,i:longint;
Begin
        u:=t;
        while u<>s do
        begin
                i:=trace[u];
                inc(e[i].f,d[t]); dec(e[-i].f,d[t]);
                u:=e[i].x;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        repeat
                if not FindPath then break;
                IncFlow;
        until false;
        FindPath2;
        res:=0;
        for i:=1 to m do
        with e[i] do
                if ((trace[x]=0) and (trace[y]<>0)) or ((trace[x]<>0) and (trace[y]=0)) then res:=res+w;
        writeln(res);
        for i:=1 to m do
        with e[i] do
                if ((trace[x]=0) and (trace[y]<>0)) or ((trace[x]<>0) and (trace[y]=0)) then write(i,' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
