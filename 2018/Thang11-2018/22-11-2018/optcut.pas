Const   ginp='optcut.inp';
        gout='optcut.out';
        maxn=2001;
        oo=trunc(1e16);

Var     n:longint;
        sum:array[0..maxn] of longint;
        pos:array[0..maxn,0..maxn] of longint;
        f:array[0..maxn,0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(sum[i]);
                sum[i]:=sum[i-1]+sum[i];
        end;
End;

Procedure Process;
Var     i,j,k,leng:longint;
Begin
        for i:=1 to n do
        begin
                pos[i,i]:=i;
                f[i,i]:=0;
        end;
        for leng:=2 to n do
        for i:=1 to n-leng+1 do
        begin
                j:=i+leng-1;
                f[i,j]:=oo;
                for k:=pos[i,j-1] to pos[i+1,j] do
                        if f[i,j]>f[i,k-1]+f[k,j]+sum[j]-sum[i-1] then
                        begin
                                f[i,j]:=f[i,k-1]+f[k,j]+sum[j]-sum[i-1];
                                pos[i,j]:=k;
                        end;
        end;
        write(f[1,n]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
