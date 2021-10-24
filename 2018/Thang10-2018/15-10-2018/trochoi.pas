Const   ginp='trochoi.inp';
        gout='trochoi.out';
        maxn=501;

Var     n:longint;
        a:array[0..maxn,0..maxn] of longint;
        f:array[0..maxn,0..maxn] of boolean;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        a[i,j]:=(a[i-1,j]+a[i,j-1]-a[i-1,j-1]+a[i,j]) mod 2;
                end;
                readln;
        end;
End;

Function Get(i,j,i0,j0:longint):longint;
Begin
        get:=(a[i,j]-a[i,j0-1]-a[i0-1,j]+a[i0-1,j0-1]+2) mod 2;
End;

Procedure Process;
Var     i,j:longint;
Begin
        for i:=1 to n do f[i,0]:=false;
        for j:=1 to n do f[0,j]:=false;
        for i:=1 to n do
                for j:=1 to n do
                begin
                        f[i,j]:=false;
                        if (get(i,j,i,1)=0) and (f[i-1,j]=false) then f[i,j]:=true;
                        if (get(i,j,1,j)=0) and (f[i,j-1]=false) then f[i,j]:=true;
                end;
        if f[n,n] then write('Teo') else write('Ti');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
