Const   ginp='maxexp.inp';
        gout='maxexp.out';
        maxn=51;
        maxg=trunc(1e18);

Var     n,m:longint;
        a:array[0..maxn] of string[51];
        f:array[0..maxn,0..maxn] of qword;
        mul:array[0..maxn,0..maxn,0..maxn,0..maxn] of qword;

Procedure Enter;
Var     i:longint;
Begin
        readln(m,n);
        for i:=1 to m do readln(a[i]);
End;

Function Max(x,y:qword):qword;
Begin
        if x>y then max:=x else max:=y;
End;

Function Min(x,y:qword):qword;
Begin
        if x<y then min:=x else min:=y;
End;

Function G(x:char):longint;
Begin
        g:=ord(x)-48;
End;

Procedure TinhMul(i,j,i1,j1:longint);
Var     rr:qword;
Begin
        if (i=i1) and (j=j1) then
        begin
                mul[i,j,i,j]:=g(a[i,j]);
                exit;
        end;
        rr:=0;
        if (i>2) and (a[i-1,j]='*') then rr:=max(rr,mul[i-2,j,i1,j1]*g(a[i,j]));
        if (j>2) and (a[i,j-1]='*') then rr:=max(rr,mul[i,j-2,i1,j1]*g(a[i,j]));
        if (i>1) and (j>1) and ((a[i-1,j]='*') or (a[i,j-1]='*')) then rr:=max(rr,mul[i-1,j-1,i1,j1]*g(a[i,j]));
        mul[i,j,i1,j1]:=min(rr,maxg);
End;

Procedure TinhRes(i,j,i1,j1:longint);
Var     rr:qword;
Begin
        if mul[i,j,i1,j1]=0 then exit;
        rr:=0;
        if (i1>2) and (a[i1-1,j1]='+') then rr:=max(rr,f[i1-2,j1]);
        if (j1>2) and (a[i1,j1-1]='+') then rr:=max(rr,f[i1,j1-2]);
        if (i1>1) and (j1>1) and ((a[i1-1,j1]='+') or (a[i1,j1-1]='+')) then rr:=max(rr,f[i1-1,j1-1]);
        f[i,j]:=max(f[i,j],min(rr+mul[i,j,i1,j1],maxg));
End;

Procedure Process;
Var     i,j,i1,j1:longint;
Begin
        f[1,1]:=g(a[1,1]);
        mul[1,1,1,1]:=f[1,1];
        for i:=1 to m do
        for j:=1 to n do
                if (i*j>1) and (g(a[i,j])>0) then
                for i1:=i downto 1 do
                for j1:=j downto 1 do
                if g(a[i1,j1])>0 then
                begin
                        tinhmul(i,j,i1,j1);
                        tinhres(i,j,i1,j1);
                end;
        if f[m,n]=maxg then write(-1) else write(f[m,n]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
