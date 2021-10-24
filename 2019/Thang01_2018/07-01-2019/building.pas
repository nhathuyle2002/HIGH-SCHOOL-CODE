Const   ginp='building.inp';
        gout='building.out';
        maxn=1001;

Var     m,n,res:longint;
        a,d:array[0..maxn,0..maxn] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        d[i,j]:=0;
                end;
                readln;
        end;
End;

Procedure Process;
Var     i,j,gmax:longint;
Begin
        for i:=1 to m do
        begin
                gmax:=0;
                for j:=1 to n do
                begin
                        if a[i,j]>=gmax then d[i,j]:=1;
                        if gmax<a[i,j] then gmax:=a[i,j];
                end;
        end;
        for i:=1 to m do
        begin
                gmax:=0;
                for j:=n downto 1 do
                begin
                        if a[i,j]>=gmax then d[i,j]:=1;
                        if gmax<a[i,j] then gmax:=a[i,j];
                end;
        end;
        for j:=1 to n do
        begin
                gmax:=0;
                for i:=1 to m do
                begin
                        if a[i,j]>=gmax then d[i,j]:=1;
                        if gmax<a[i,j] then gmax:=a[i,j];
                end;
        end;
        for j:=1 to n do
        begin
                gmax:=0;
                for i:=m downto 1 do
                begin
                        if a[i,j]>=gmax then d[i,j]:=1;
                        if gmax<a[i,j] then gmax:=a[i,j];
                end;
        end;
        res:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if d[i,j]=0 then inc(res);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
