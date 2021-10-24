Uses    Math;

Const   ginp='clock.inp';
        gout='clock.out';
        maxn=1000001;

Var     n:longint;
        a:array[0..maxn] of longint;
        f:array[0..maxn,0..11] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i]);
                a[i]:=a[i] mod 12;
        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        for i:=1 to n do
                for j:=0 to 11 do
                        f[i,j]:=(a[i]+12-j) mod 12+f[i-1,(12-a[i]+j) mod 12];
        for j:=1 to 11 do f[n,0]:=min(f[n,0],f[n,j]+12-j);
        write(f[n,0]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
