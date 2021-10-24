Const   ginp='kquery.inp';
        gout='kquery.out';
        maxn=100010;
        maxm=trunc(sqrt(maxn))+1;
        maxg=10010;

Var     n,m,nm,q,res:longint;
        a:array[0..maxn] of longint;
        f:array[0..maxg,0..maxm] of longint;

Procedure Update(x,y,w:longint);
Var     i,j:longint;
Begin
        i:=x;
        while i<=maxg do
        begin
                j:=y;
                while j<=nm do
                begin
                        f[i,j]:=f[i,j]+w;
                        j:=j+j and (-j);
                end;
                i:=i+i and (-i);
        end;
End;

Function Quece(x,y:longint):longint;
Var     i,j:longint;
Begin
        quece:=0; i:=x;
        while i>0 do
        begin
                j:=y;
                while j>0 do
                begin
                        quece:=quece+f[i,j];
                        j:=j-j and (-j);
                end;
                i:=i-i and (-i);
        end;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n); m:=trunc(sqrt(n));
        nm:=(n-1) div m+1;
        for i:=1 to n do
        begin
                read(a[i]);
                update(a[i],(i-1) div m+1,1);
        end;
End;

Procedure Process;
Var     i,j,k,t,bli,blj,ij:longint;
        id:string[1];
Begin
        readln(q);
        for t:=1 to q do
        begin
                read(id);
                if id='S' then
                begin
                        readln(i,k);
                        update(a[i],(i-1) div m+1,-1);
                        update(k,(i-1) div m+1,1);
                        a[i]:=k;
                end else
                begin
                        readln(i,j,k); inc(k);
                        bli:=(i-1) div m+1; blj:=(j-1) div m+1;
                        res:=quece(maxg,blj)-quece(maxg,bli-1)-quece(k-1,blj)+quece(k-1,bli-1);
                        for ij:=(bli-1)*m+1 to i-1 do
                                if a[ij]>=k then dec(res);
                        for ij:=j+1 to blj*m do
                                if a[ij]>=k then dec(res);
                        writeln(res);
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
