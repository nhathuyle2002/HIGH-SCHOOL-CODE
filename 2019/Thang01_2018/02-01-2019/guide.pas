Const   ginp='guide.inp';
        gout='guide.out';
        maxn=100010;

Var     n:longint;
        a,b,trace:array[0..maxn] of longint;
        f:array[0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
        readln;
        for i:=1 to n do read(b[i]);
End;

Procedure Process;
Var     i,j,cou,ir:longint;
        o:array[0..maxn] of longint;
Begin
        ir:=0; f[0]:=0;
        for i:=1 to n do
        begin
                f[i]:=0;
                for j:=i-1 downto 0 do
                        if (a[j]<a[i]) and (b[j]<b[i]) and (f[i]<f[j]+a[i]+b[i]) then
                        begin
                                f[i]:=f[j]+a[i]+b[i];
                                trace[i]:=j;
                        end;
                if f[i]>f[ir] then ir:=i;
        end;
        writeln(f[ir]);
        cou:=0;
        while ir<>0 do
        begin
                inc(cou);
                o[cou]:=ir;
                ir:=trace[ir];
        end;
        for i:=cou downto 1 do write(o[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
