Const   ginp='muaqua.inp';
        gout='muaqua.out';
        maxn=21;
        maxs=2001;

Var     n,k,s:longint;
        c:array[0..maxn,0..maxn] of longint;
        f:array[0..maxn,0..maxs,0..maxn] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(k,n,s);
        for i:=1 to n do
        begin
                for j:=1 to k do read(c[i,j]);
                c[i,k+1]:=maxs;
                readln;
        end;
End;

Procedure Process;
Var     i1,i2,i,j:longint;
Begin
        for i2:=1 to n do f[k+1,0,i2]:=1;
        for i:=k downto 1 do
        for j:=0 to s do
                for i1:=1 to n do
                for i2:=1 to n do
                        if (j-c[i1,i]>=0) and (f[i+1,j-c[i1,i],i2]>0) and (c[i1,i]<=c[i2,i+1]) and ((f[i,j,i1]=0) or (c[i2,i+1]<c[f[i,j,i1],i+1]))
                        then f[i,j,i1]:=i2;
        i2:=0;
        for i1:=1 to n do
                if (f[1,s,i1]>0) and ((i2=0) or (c[i1,1]<c[i2,1])) then i2:=i1;
        if i2=0 then write('NO') else
        begin
                writeln('YES');
                i:=1; j:=s; i1:=i2;
                while i<=k do
                begin
                        write(c[i1,i],' ');
                        i2:=f[i,j,i1]; j:=j-c[i1,i];
                        i1:=i2; inc(i);
                end;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
