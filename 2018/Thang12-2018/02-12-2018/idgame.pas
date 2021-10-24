Const   ginp='idgame.inp';
        gout='idgame.out';
        maxn=1000001;

Var     n,nq:longint;
        q:array[0..maxn] of longint;
        d:array[-maxn..maxn] of longint;
        f:array[0..2*maxn] of int64;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(n,nq);
        for i:=1 to n do
        begin
                read(x);
                inc(d[x]);
        end;
        readln;
        for i:=1 to nq do read(q[i]);
End;

Procedure Process;
Var     i,l,r,coul,cour:longint;
Begin
        f[2*maxn]:=0;
        l:=-maxn; r:=maxn;
        coul:=0; cour:=0;
        while l<r do
                if coul<=cour then
                begin
                        f[r-l-1]:=f[r-l]+coul;
                        cour:=cour-coul; d[r-1]:=d[r-1]+coul;
                        inc(l); coul:=coul+d[l];
                end else
                begin
                        f[r-l-1]:=f[r-l]+cour;
                        coul:=coul-cour; d[l+1]:=d[l+1]+cour;
                        dec(r); cour:=cour+d[r];
                end;
        for i:=1 to nq do writeln(f[q[i]]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
