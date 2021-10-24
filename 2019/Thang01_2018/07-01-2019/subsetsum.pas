Const   ginp='subsetsum.inp';
        gout='subsetsum.out';
        maxn=101;

Var     n,m,cou:longint;
        a,o:array[0..maxn] of longint;
        f:array[0..maxn,0..maxn*1000] of boolean;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to n do read(a[i]);
End;

Procedure Trace(i,j:longint);
Begin
        if i=0 then exit;
        if f[i-1,j] then trace(i-1,j) else
        begin
                inc(cou);
                o[cou]:=i;
                trace(i-1,j-a[i]);
        end;
End;

Procedure Process;
Var     i,j,sum:longint;
Begin
        sum:=0;
        for i:=1 to n do sum:=sum+a[i];
        if m>sum then
        begin
                write('NO');
                exit;
        end;
        fillchar(f,sizeof(f),false);
        f[0,0]:=true;
        for i:=1 to n do
                for j:=0 to m do
                        if (f[i-1,j]) or ((j>=a[i]) and (f[i-1,j-a[i]])) then f[i,j]:=true;
        if not f[n,m] then write('NO') else
        begin
                writeln('YES');
                cou:=0;
                trace(n,m);
                for i:=cou downto 1 do write(o[i],' ');
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
