Uses    Math;

Const   ginp='line2.inp';
        gout='line2.out';
        maxn=201;
        oo=trunc(1e7);

Var     n,res:longint;
        fx,fy,matchx,matchy,trace:array[0..maxn] of longint;
        c:array[0..maxn,0..maxn] of longint;

Procedure Enter;
Var     i,j,x:longint;
Begin
        readln(n);
        for i:=1 to n do
                for j:=1 to n do c[i,j]:=oo;
        while not seekeof do
        begin
                readln(i,j,x);
                c[i,j]:=min(c[i,j],x);
        end;
End;

Function Get(i,j:longint):longint;
Begin
        get:=c[i,j]-fx[i]-fy[j];
End;

Function FindPath(s:longint):longint;
Var     l,r,x,y:longint;
        q:array[0..maxn] of longint;
Begin
        for x:=1 to n do trace[x]:=0;
        l:=1; r:=1; q[1]:=s;
        repeat
                x:=q[l]; inc(l);
                for y:=1 to n do
                        if (trace[y]=0) and (get(x,y)=0) then
                        begin
                                trace[y]:=x;
                                if matchy[y]=0 then exit(y) else
                                inc(r);
                                q[r]:=matchy[y];
                        end;
        until l>r;
        exit(0);
End;

Procedure UdEdge(s:longint);
Var     x,y,del:longint;
        visitx,visity:array[0..maxn] of boolean;
Begin
        for x:=1 to n do visitx[x]:=false;
        for y:=1 to n do visity[y]:=false;
        visitx[s]:=true;
        for y:=1 to n do
                if trace[y]>0 then
                begin
                        visity[y]:=true;
                        visitx[matchy[y]]:=true;
                end;
        del:=oo;
        for x:=1 to n do
        if visitx[x] then
                for y:=1 to n do
                if not visity[y] then del:=min(del,get(x,y));
        for x:=1 to n do
                if visitx[x] then fx[x]:=fx[x]+del;
        for y:=1 to n do
                if visity[y] then fy[y]:=fy[y]-del;
End;

Procedure IncFlow(t:longint);
Var     t2,x:longint;
Begin
        repeat
                x:=trace[t];
                t2:=matchx[x];
                matchy[t]:=x;
                matchx[x]:=t;
                t:=t2;
        until t=0;
End;

Procedure Init;
Var     i,j:longint;
Begin
        for i:=1 to n do
        begin
                matchx[i]:=0;
                matchy[i]:=0;
        end;
        for i:=1 to n do
        begin
                fx[i]:=oo;
                for j:=1 to n do fx[i]:=min(fx[i],c[i,j]);
        end;
        for j:=1 to n do
        begin
                fy[j]:=oo;
                for i:=1 to n do fy[j]:=min(fy[j],c[i,j]-fx[i]);
        end;
End;

Procedure Process;
Var     x,y:longint;
Begin
        for x:=1 to n do
        begin
                repeat
                        y:=FindPath(x);
                        if y=0 then UdEdge(x) else break;
                until false;
                IncFlow(y);
        end;
        res:=0;
        for x:=1 to n do res:=res+c[x,matchx[x]];
        writeln(res);
        for x:=1 to n do writeln(x,' ',matchx[x]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        Process;
        Close(input); Close(output);
End.
