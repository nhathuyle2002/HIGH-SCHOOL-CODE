Const   ginp='reduce.inp';
        gout='reduce.out';
        maxn=201;
        maxg=40010;

Var     n,maxs,start:longint;
        a:array[0..maxn] of longint;
        b:array[0..2*maxn] of longint;
        d:array[0..maxn,-maxg..maxg] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,maxs);
        for i:=1 to n do read(a[i]);
End;

Procedure Answer(i,j:longint);
Begin
        if i=0 then exit;
        if d[i,j]=1 then
        begin
                b[i]:=1; j:=j-a[i];
        end else
        begin
                b[i]:=-1; j:=j+a[i];
        end;
        answer(i-1,j);
End;

Procedure Process;
Var     i,j,j1,j2,cou,dcou:longint;
Begin
        d[0,0]:=1;
        for i:=1 to n do
                for j:=-maxg to maxg do
                begin
                        j1:=j+a[i]; j2:=j-a[i];
                        if (j1<=maxg) and (d[i-1,j1]<>0) then d[i,j]:=-1 else
                        if (j2>=-maxg) and (d[i-1,j2]<>0) then d[i,j]:=1 else
                        d[i,j]:=0;
                end;
        answer(n,maxs);
        for i:=n+1 to 2*n do b[i]:=b[i-n];
        for start:=1 to n do
                if (b[start]=1) and (b[start+1]=-1) then break;
        cou:=0; dcou:=0;
        b[start+n]:=b[start+n-1];
        for i:=start+n-1 downto start do
                if b[i]=b[i+1] then inc(cou) else
                begin
                for j:=1 to cou do
                begin
                        if i>n then write(i-n-1,' ')
                        else write(i-dcou-1,' ');
                        if i+j>n then inc(dcou);
                end;
                cou:=1;
                end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
