Uses    Math;

Const   ginp='sequence.inp';
        gout='sequence.out';
        maxn=3001;
        oo=2*trunc(1e9);

Var     na,nb,k,nc,nd,ne:longint;
        a,b,c,d,e,r:array[0..maxn] of longint;
        fa,fb:array[0..maxn,0..maxn] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(na,nb,k);
        for i:=1 to na do read(a[i]); readln;
        for i:=1 to nb do read(b[i]);
End;

Procedure Tva(i,j:longint);
Var     i0:longint;
Begin
        if j=0 then exit;
        i0:=fa[i,na-j+1];
        inc(nc); c[nc]:=a[i0];
        tva(i0+1,j-1);
End;

Procedure Tvb(i,j:longint);
Var     i0:longint;
Begin
        if j=0 then exit;
        i0:=fb[i,nb-j+1];
        inc(nd); d[nd]:=b[i0];
        tvb(i0+1,j-1);
End;

Procedure Init;
Var     i,j:longint;
Begin
        for i:=1 to na do
        begin
                fa[i,i]:=i;
                for j:=i+1 to na do
                        if a[j]<a[fa[i,j-1]] then fa[i,j]:=j else fa[i,j]:=fa[i,j-1];
        end;
        for i:=1 to nb do
        begin
                fb[i,i]:=i;
                for j:=i+1 to nb do
                        if b[j]<b[fb[i,j-1]] then fb[i,j]:=j else fb[i,j]:=fb[i,j-1];
        end;
End;

Function Check:boolean;
Var     i:longint;
Begin
        for i:=1 to k do
                if e[i]<r[i] then exit(true) else
                if e[i]>r[i] then exit(false);
        exit(false);
End;

Procedure Process;
Var     i,j,x:longint;
Begin
        for x:=max(0,k-nb) to min(na,k) do
        begin
                nc:=0; tva(1,x);
                nd:=0; tvb(1,k-x);
                ne:=0; j:=1;
                for i:=1 to nc do
                begin
                        while (j<=nd) and (d[j]<c[i]) do
                        begin
                                inc(ne); e[ne]:=d[j];
                                inc(j);
                        end;
                        inc(ne); e[ne]:=c[i];
                end;
                for i:=j to nd do
                begin
                        inc(ne); e[ne]:=d[i];
                end;
                if (x=max(0,k-nb)) or (check) then r:=e;
        end;
        for i:=1 to k do write(r[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        Process;
        Close(input); Close(output);
End.
