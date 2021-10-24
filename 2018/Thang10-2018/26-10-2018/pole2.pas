Uses    Math;

Const   ginp='pole2.inp';
        gout='pole2.out';
        maxn=4001;
        oo=trunc(1e13);

Type    save=record j:longint; g:int64; end;

Var     n,d,l,r:longint;
        res:int64;
        c,h:array[0..maxn] of longint;
        f:array[0..maxn,0..maxn] of int64;
        q:array[0..maxn] of save;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,d);
        for i:=2 to n do read(c[i]); readln;
        for i:=1 to n do read(h[i]);
End;

Procedure Pop(j,typ:longint);
Begin
        if typ=1 then
        while (l<=r) and (q[l].j<j) do inc(l)
        else if typ=2 then
        while (l<=r) and (q[l].j>j) do inc(l);
End;

Procedure Push(j:longint;x:int64);
Begin
        while (l<=r) and (q[r].g>=x) do dec(r);
        inc(r); q[r].j:=j; q[r].g:=x;
End;

Procedure Process;
Var     i,j:longint;
Begin
        for j:=1 to maxn do
                if j<h[1] then f[1,j]:=oo else f[1,j]:=sqr(j-h[1]);
        for i:=2 to n do
        begin
                l:=1; r:=0;
                for j:=1 to maxn do
                begin
                        pop(j-d,1); push(j,f[i-1,j]-c[i]*j);
                        if j<h[i] then f[i,j]:=oo else f[i,j]:=q[l].g+c[i]*j+sqr(j-h[i]);
                end;
                l:=1; r:=0;
                for j:=maxn downto h[i] do
                begin
                        pop(j+d,2); push(j,f[i-1,j]+c[i]*j);
                        f[i,j]:=min(f[i,j],q[l].g-c[i]*j+sqr(j-h[i]));
                end;
        end;
        res:=oo;
        for j:=1 to maxn do res:=min(res,f[n,j]);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
