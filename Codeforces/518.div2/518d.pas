Const   ginp='ss.inp';
        gout='ss.out';
        maxn=100010;
        base=998244353;
        mg=200;

Var     n:longint;
        a:array[0..maxn] of longint;
        f:array[0..maxn,0..mg,0..2] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
End;

Procedure Process;
Var     i,j,k:longint;
        tmp:int64;
Begin
        for j:=1 to mg do
        begin
                f[1,j,2]:=f[1,j-1,2];
                if (a[1]=-1) or (j=a[1]) then inc(f[1,j,2]);
        end;
        for i:=2 to n do
                for j:=1 to mg do
                for k:=0 to 2 do
                begin
                        f[i,j,k]:=f[i,j-1,k];
                        if (a[i]<>-1) and (j<>a[i]) then continue;
                        if k=0 then tmp:=f[i-1,mg,0]-f[i-1,j,0]+f[i-1,mg,1]-f[i-1,j,1] else
                        if k=1 then tmp:=f[i-1,j,0]-f[i-1,j-1,0]+f[i-1,j,1]-f[i-1,j-1,1]+f[i-1,j,2]-f[i-1,j-1,2] else
                        if k=2 then tmp:=f[i-1,j-1,0]+f[i-1,j-1,1]+f[i-1,j-1,2];
                        f[i,j,k]:=(f[i,j,k]+tmp) mod base;
                end;
        write((f[n,mg,0]+f[n,mg,1]+2*base) mod base);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
