Const   ginp='tiles.inp';
        gout='tiles.out';
        base=trunc(1e15);
        maxn=1001;

Var     n:longint;
        f:array[0..maxn] of int64;
        d:array[1..5] of longint;

Function Mul(a,b:int64):int64;
Begin
        if b=0 then exit(0);
        mul:=(mul(a div 10,b*10 mod base)+a mod 10*b mod base) mod base;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to 5 do readln(d[i]);
End;

Procedure Process;
Var     i:longint;
Begin
        f[0]:=1;
        for i:=1 to n do
        begin
                f[i]:=0;
                if d[1]=1 then f[i]:=f[i]+mul(f[i-1],f[i-1]);
                if (d[2]=1) and (i>1) then f[i]:=f[i]+mul(mul(f[i-2],f[i-2]),mul(f[i-2],f[i-2]));
                if (d[3]=1) and (i>3) then f[i]:=f[i]+mul(mul(f[i-1],f[i-2]),mul(f[i-3],mul(f[i-4],f[i-4])));
                if (d[4]=1) and (i>3) then f[i]:=f[i]+mul(mul(f[i-1],f[i-2]),mul(f[i-3],mul(f[i-4],f[i-4])));
                if (d[5]=1) and (i>2) then f[i]:=f[i]+mul(mul(f[i-2],f[i-2]),mul(mul(f[i-3],f[i-3]),mul(f[i-3],f[i-3])));
                f[i]:=f[i] mod base;
        end;
        write(f[n]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
