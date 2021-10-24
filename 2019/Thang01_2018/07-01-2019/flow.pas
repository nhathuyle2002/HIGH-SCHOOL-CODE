Uses    Math;

Const   ginp='flow.inp';
        gout='flow.out';
        maxn=100010;
        oo=trunc(1e9)+100;

Type    edge= record x,y,link,w,f:longint; end;

Var     n,m,s,t:longint;
        res:int64;
        head:array[0..maxn] of longint;
        e:array[-maxn..maxn] of edge;
        l,r:longint;
        d,trace,q:array[0..maxn] of longint;

Procedure Add(i,u,v,c,ff:longint);
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
        readln(n,m,s,t);
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c,0);
                add(-i,v,u,0,0);
        end;
End;

Function FindPath(s,t:longint):boolean;
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

Procedure IncFlow(s,t:longint);
Var     delta,u,i:longint;
Begin
        delta:=d[t];
        u:=t;
        while u<>s do
        begin
                i:=trace[u];
                inc(e[i].f,delta); dec(e[-i].f,delta);
                u:=e[i].x;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        repeat
                if not FindPath(s,t) then break;
                IncFlow(s,t);
        until false;
        res:=0;
        i:=head[s];
        while i<>0 do
        with e[i] do
        begin
                if i>0 then res:=res+f;
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
