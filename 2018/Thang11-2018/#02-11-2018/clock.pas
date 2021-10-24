Uses    Math;

Const   ginp='clock.inp';
        gout='clock.out';
        maxn=1000010;

Var     n,res:longint;
        a:array[0..maxn] of longint;
        f:array[0..maxn,1..12] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i]);
                a[i]:=(a[i]-1) mod 12+1;
        end;
End;

Procedure Process;
Var     i,j,k:longint;
Begin
        for j:=1 to 12 do f[1,j]:=(a[1]-j+12) mod 12;
        for i:=2 to n do
                for j:=1 to 12 do
                begin
                        k:=(a[i]-j+12) mod 12;
                        f[i,j]:=k+f[i-1,12-k];
                end;
        res:=n*12;
        for j:=1 to 12 do res:=min(res,f[n,j]+12-j);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
