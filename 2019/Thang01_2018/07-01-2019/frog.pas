Const   ginp='frog.inp';
        gout='frog.out';
        maxn=1001;

Var     m,n,k:longint;
        res:int64;
        a,trace:array[0..maxn,0..maxn] of longint;
        f:array[0..maxn,0..maxn] of int64;
        l,r:longint;
        q,o:array[0..maxn] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
End;

Procedure Push(i,j:longint);
Begin
        while (l<=r) and (f[i,j]>=f[i,q[r]]) do dec(r);
        inc(r); q[r]:=j;
End;

Procedure Pop(j:longint);
Begin
        while (l<=r) and (q[l]<=j) do inc(l);
End;

Procedure Process;
Var     i,j:longint;
Begin
        for j:=1 to n do f[1,j]:=a[1,j];
        for i:=2 to m do
        begin
                l:=1; r:=0;
                for j:=1 to k do push(i-1,j);
                for j:=1 to n do
                begin
                        pop(j-k-1);
                        if j+k<=n then push(i-1,j+k);
                        f[i,j]:=f[i-1,q[l]]+a[i,j];
                        trace[i,j]:=q[l];
                end;
        end;
        res:=0;
        for j:=1 to n do
                if f[m,res]<f[m,j] then res:=j;
        writeln(f[m,res]);
        i:=m; j:=res;
        while i>0 do
        begin
                o[i]:=j;
                j:=trace[i,j]; dec(i);
        end;
        for i:=1 to m do writeln(o[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
