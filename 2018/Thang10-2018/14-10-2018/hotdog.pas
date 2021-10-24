Uses    Math;

Const   ginp='hotdog.inp';
        gout='hotdog.out';
        maxn=101;
        maxg=100010;

Var     na,nb,res:longint;
        a,b:array[0..maxn] of longint;
        fa,fb:array[0..maxn,0..maxg] of longint;

Procedure Enter;
Var     i:longint;
Begin
        read(na);
        for i:=1 to na do read(a[i]);
        readln;
        read(nb);
        for i:=1 to nb do read(b[i]);
End;

Procedure Process;
Var     i,j:longint;
Begin
        fa[0,0]:=0; fb[0,0]:=0;
        for j:=1 to maxg do
        begin
                fa[0,j]:=maxn+1;
                fb[0,j]:=maxn+1;
        end;
        for i:=1 to na do
                for j:=0 to maxg do
                begin
                        fa[i,j]:=fa[i-1,j];
                        if j>=a[i] then fa[i,j]:=min(fa[i,j],fa[i-1,j-a[i]]+1);
                end;
        for i:=1 to nb do
                for j:=0 to maxg do
                begin
                        fb[i,j]:=fb[i-1,j];
                        if j>=b[i] then fb[i,j]:=min(fb[i,j],fb[i-1,j-b[i]]+1);
                end;
        res:=3*maxn;
        for j:=1 to maxg do
                if (fa[na,j]<maxn+1) and (fb[nb,j]<maxn+1) then res:=min(res,fa[na,j]+fb[nb,j]);
        if res=3*maxn then write('impossible') else write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
