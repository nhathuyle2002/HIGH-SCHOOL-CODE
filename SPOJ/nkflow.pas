Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';
        maxn=1010;
        maxm=1000010;
        oo=trunc(1e8);

Type    edge= record x,y,link,w,f:longint; end;

Var     n,m,start,finish:longint;
        res:int64;
        e:array[-maxm..maxm] of edge;
        head,trace,d:array[0..maxn] of longint;

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
        readln(n,m,start,finish);
        for i:=1 to m do
        begin
                readln(u,v,c);
                add(i,u,v,c);
                add(-i,v,u,0);
        end;
End;

Function FindPath(s,t:longint):boolean;
Var     i,u,l,r:longint;
        q:array[0..maxn] of longint;
Begin
        for u:=1 to n do trace[u]:=0;
        l:=1; r:=1; q[1]:=s; trace[s]:=oo; d[s]:=oo;
        repeat
                u:=q[l]; inc(l);
                i:=head[u];
                while i<>0 do
                with e[i] do
                begin
                        if trace[y]=0 then
                        begin
                                if (i>0) and (f<w) then
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
                                        if y=t then exit(true);
                                        inc(r); q[r]:=y;
                                end;
                        end;
                        i:=link;
                end;
        until l>r;
        findpath:=false;
End;

Procedure IncFlow(s,t:longint);
Var     u,i,incf:longint;
Begin
        u:=t; incf:=d[t];
        repeat
                i:=trace[u];
                if i>0 then e[i].f:=e[i].f+incf else e[-i].f:=e[-i].f-incf;
                u:=e[i].x;
        until u=s;
End;

Procedure Process;
Var     i:longint;
Begin
        repeat
                if not findpath(start,finish) then break;
                incflow(start,finish);
        until false;
        res:=0;
        i:=head[start];
        while i<>0 do
        with e[i] do
        begin
                if i>0 then res:=res+e[i].f;
                i:=link;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
