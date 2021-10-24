Uses    Math;

Const   ginp='chip.inp';
        gout='chip.out';
        maxn=33;

Var     m,n,k,res:longint;
        a:array[0..maxn] of string[40];
        d,f:array[0..maxn,0..maxn] of longint;
        dd:array[0..maxn,0..maxn] of boolean;
        oi,oj,ok:array[0..maxn*maxn] of longint;

Procedure NP(kk,cc:longint);
Var     i,j,ri,rj,cou:longint;
Begin
        ri:=0; rj:=0;
                for i:=1 to m do
                        for j:=1 to n do
                                if d[i,j]<>0 then f[i,j]:=0 else
                                begin
                                        f[i,j]:=min(f[i-1,j-1],min(f[i,j-1],f[i-1,j]))+1;
                                        if f[ri,rj]<f[i,j] then
                                        begin
                                                ri:=i; rj:=j;
                                        end;
                                end;
        if f[ri,rj]<=res then exit;
        if kk=k+1 then
        begin
                res:=f[ri,rj];
                for i:=1 to m do
                        for j:=1 to n do dd[i,j]:=true;
                cou:=0;
                for i:=1 to m do
                        for j:=1 to n do
                                if (d[i,j]>0) and (dd[i,j]) then
                                begin
                                        inc(cou);
                                        oi[cou]:=i; oj[cou]:=j; ok[cou]:=d[i,j];
                                        if d[i,j]=1 then dd[i,j+1]:=false
                                        else dd[i+1,j]:=false;
                                end;
                exit;
        end;
        for cou:=cc+1 to m*n-1 do
        begin
                i:=(cou-1) div n+1; j:=(cou-1) mod n+1;
                if (d[i,j]=0) and (d[i,j+1]=0) then
                begin
                        d[i,j]:=1; d[i,j+1]:=1;
                        NP(kk+1,cou);
                        d[i,j]:=0; d[i,j+1]:=0;
                end;
                if (d[i,j]=0) and (d[i+1,j]=0) then
                begin
                        d[i,j]:=2; d[i+1,j]:=2;
                        NP(kk+1,cou);
                        d[i,j]:=0; d[i+1,j]:=0;
                end;
        end;
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n,k);
        for i:=1 to m do
        begin
                d[i,0]:=-1; d[i,n+1]:=-1;
        end;
        for j:=1 to n do
        begin
                d[0,j]:=-1; d[m+1,j]:=-1;
        end;
        for i:=1 to m do
        begin
                readln(a[i]);
                for j:=1 to n do
                        if a[i,j]='#' then d[i,j]:=-1;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        NP(1,0);
        for i:=1 to k do writeln(oi[i],' ',oj[i],' ',ok[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
