Const   ginp='ss.inp';
        gout='ss.out';
        maxn=100010;

Var     n:longint;
        a,b,ou:array[0..maxn] of longint;
        f:array[0..maxn,0..3] of boolean;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n-1 do read(a[i]); readln;
        for i:=1 to n-1 do read(b[i]);
End;

Procedure Answ(i,j:longint);
Var     jj:longint;
Begin
        ou[i]:=j;
        if i=0 then exit;
        for jj:=0 to 3 do
                if (f[i-1,jj]) and (j or jj=a[i]) and (j and jj=b[i]) then
                begin
                        answ(i-1,jj);
                        exit;
                end;
End;

Procedure Process;
Var     i,j,jj:longint;
Begin
        for j:=0 to 3 do f[0,j]:=true;
        for i:=1 to n-1 do
                for j:=0 to 3 do
                begin
                        f[i,j]:=false;
                        for jj:=0 to 3 do
                                if (f[i-1,jj]) and (j or jj=a[i]) and (j and jj=b[i]) then f[i,j]:=true;
                end;
        for j:=0 to 3 do
                if f[n-1,j] then
                begin
                        answ(n-1,j);
                        writeln('YES');
                        for i:=0 to n-1 do write(ou[i],' ');
                        exit;
                end;
        write('NO');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
