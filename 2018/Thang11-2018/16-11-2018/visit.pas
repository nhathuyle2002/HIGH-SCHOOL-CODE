Const   ginp='visit.inp';
        gout='visit.out';
        maxn=101;
        maxs=50001;

Var     n,res:longint;
        a,s:array[0..maxn] of longint;
        f:array[0..maxn,0..maxs] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i]);
                s[i]:=s[i-1]+a[i];
        end;
End;

Procedure Process;
Var     i,j,k:longint;

Function Min(x,y:longint):longint;
Begin
        if x<y then min:=x else min:=y;
End;

Begin
        f[0,0]:=1;
        for i:=1 to n do
                for j:=min(n shr 1,i-1) downto 0 do
                for k:=0 to s[i]-a[i] do
                        if f[j,k]=1 then f[j+1,k+a[i]]:=1;
        res:=0;
        for k:=0 to s[n] shr 1 do
                if (f[n shr 1,k]=1) or (f[n shr 1,s[n]-k]=1) then res:=k;
        write(res,' ',s[n]-res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
