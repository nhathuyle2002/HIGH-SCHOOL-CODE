Const   ginp='bseq.inp';
        gout='bseq.out';
        maxn=5010;

Var     m,n:longint;
        f:array[1..2,0..maxn,0..maxn] of longint;
        a,b:array[0..maxn] of longint;

function max(x,y:longint):longint; inline;
begin
        if x>y then exit(x) else exit(y);
end;

Procedure Enter;
Var     i:longint;
Begin
        readln(m,n);
        for i:=1 to m do read(a[i]); readln;
        for i:=1 to n do read(b[i]);
End;

Procedure Process;
Var     i,j:longint;
Begin
        for i:=1 to m do
                for j:=1 to n do
                begin
                        f[1,i,j]:=max(f[1,i-1,j],f[1,i,j-1]);
                        if a[i]>=b[j] then f[1,i,j]:=max(f[1,i,j],f[2,i-1,j-1]+1);
                        f[2,i,j]:=max(f[2,i-1,j],f[2,i,j-1]);
                        if a[i]<=b[j] then f[2,i,j]:=max(f[2,i,j],f[1,i-1,j-1]+1);
                end;
        write(max(f[1,m,n],f[2,m,n]));
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
