Const   ginp='ed.inp';
        gout='ed.out';
        maxn=1501;

Var     st,m,n:longint;
        a,b:ansistring;
        f:array[0..maxn,0..maxn] of longint;

Procedure Enter;
Begin
        readln(a); m:=length(a);
        readln(b); n:=length(b);
End;

Procedure Process;
Var     i,j:longint;

        Function Min(x,y:longint):longint;
        Begin
                if x<y then min:=x else min:=y;
        End;

Begin
        for i:=1 to m do f[i,0]:=i;
        for j:=1 to n do f[0,j]:=j;
        for i:=1 to m do
                for j:=1 to n do
                begin
                        f[i,j]:=min(f[i-1,j-1],min(f[i-1,j],f[i,j-1]))+1;
                        if a[i]=b[j] then f[i,j]:=min(f[i,j],f[i-1,j-1]);
                end;
        writeln(f[m,n]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                Process;
        end;
        Close(input); Close(output);
End.
