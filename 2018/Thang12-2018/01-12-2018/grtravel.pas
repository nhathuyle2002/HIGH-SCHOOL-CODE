Const   ginp='grtravel.inp';
        gout='grtravel.out';
        maxn=100001;

Var     n:longint;
        res:int64;
        deg:array[0..maxn] of longint;

Procedure Enter;
Var     i,x,y,m:longint;
Begin
        readln(n,m);
        for i:=1 to n do deg[i]:=n-i;
        for i:=1 to m do
        begin
                readln(x,y);
                dec(deg[x]); inc(deg[y]);
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        res:=int64(n)*(n-1)*(n-2) div 6;
        for i:=1 to n do
                res:=res-int64(deg[i])*(deg[i]-1) div 2;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
