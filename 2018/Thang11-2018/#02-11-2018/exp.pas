Uses    Math;

Const   ginp='exp.inp';
        gout='exp.out';
        maxn=51;
        maxw=trunc(1e18);

Var     m,n:longint;
        mw:int64;
        a:array[0..maxn] of string[51];
        f:array[0..maxn,0..maxn] of int64;
        mul:array[0..maxn,0..maxn,0..maxn,0..maxn] of int64;

Function G(i,j:longint):longint;
Begin
        g:=ord(a[i,j])-48;
End;

Procedure CnMul(i,j,ii,jj:longint);
Begin
        if (j>1) and (a[i,j-1]='*') then
                mul[i,j,ii,jj]:=max(mul[i,j,ii,jj],max(mul[i,j-2,ii,jj],mul[i-1,j-1,ii,jj])*g(i,j));
        if (i>1) and (a[i-1,j]='*') then
                mul[i,j,ii,jj]:=max(mul[i,j,ii,jj],max(mul[i-2,j,ii,jj],mul[i-1,j-1,ii,jj])*g(i,j));
End;

Procedure CnF(i,j,ii,jj:longint);
Begin
        if (ii=1) and (jj=1) then
                f[i,j]:=max(f[i,j],mul[i,j,1,1]);
        if (jj>1) and (a[ii,jj-1]='+') then
                f[i,j]:=max(f[i,j],max(f[ii,jj-2],f[ii-1,jj-1])+mul[i,j,ii,jj]);
        if (ii>1) and (a[ii-1,jj]='+') then
                f[i,j]:=max(f[i,j],max(f[ii-2,jj],f[ii-1,jj-1])+mul[i,j,ii,jj]);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(m,n);
        for i:=1 to m do readln(a[i]);
End;

Procedure Process;
Var     i,j,ii,jj:longint;
Begin
        mw:=0;
        f[1,1]:=g(1,1);
        mul[1,1,1,1]:=g(1,1);
        for i:=1 to m do
        for j:=1 to n do
                if (i*j=1) or (a[i,j]<'1') then continue else
                begin
                        mul[i,j,i,j]:=g(i,j);
                        cnf(i,j,i,j);
                        for ii:=i downto 1 do
                        for jj:=j downto 1 do
                        if (a[i,j]>='1') and ((ii<i) or (jj<j)) then
                        begin
                                cnmul(i,j,ii,jj);
                                mw:=max(mw,mul[i,j,ii,jj]);
                                cnf(i,j,ii,jj);
                        end;
                        mw:=max(mw,f[i,j]);
                        if mw>maxw then exit;
                end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        if mw>maxw then write(-1) else write(f[m,n]);
        Close(input); Close(output);
End.
