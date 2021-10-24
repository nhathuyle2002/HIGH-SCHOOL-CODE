Const   ginp='lamps.inp';
        gout='lamps.out';
        maxn=201;

Var     m,n,mdeg:longint;
        a,res:array[0..maxn,0..maxn] of longint;
        pos:array[-maxn..maxn,0..maxn] of longint;

Procedure Enter;
Var     i,j:longint;
        drd,dcl:array[0..maxn] of longint;
Begin
        readln(m,n);
        for i:=1 to m do drd[i]:=0;
        for j:=1 to n do dcl[j]:=0;
        while not seekeof do
        begin
                readln(i,j);
                a[i,j]:=1;
                inc(drd[i]); inc(dcl[j]);
        end;
        mdeg:=0;
        for i:=1 to m do
                if drd[i]>mdeg then mdeg:=drd[i];
        for j:=1 to n do
                if dcl[j]>mdeg then mdeg:=dcl[j];
End;

Procedure Swap(var x,y:longint);
Var     tmp:longint;
Begin
        tmp:=x; x:=y; y:=tmp;
End;

Procedure Process;
Var     i,j,k,p1,p2,x:longint;
Begin
        for i:=1 to m do
        for j:=1 to n do
                if a[i,j]=1 then
                begin
                        p1:=0;
                        for k:=1 to mdeg do
                                if (pos[i,k]=0) and (pos[-j,k]=0) then
                                begin
                                        pos[i,k]:=-j; pos[-j,k]:=i;
                                        p1:=-1;
                                        break;
                                end else
                                if (pos[i,k]=0) and (pos[-j,k]<>0) then p1:=k else
                                if (pos[-j,k]=0) and (pos[i,k]<>0) then p2:=k;
                        if p1=-1 then continue else
                        begin
                                k:=p1; x:=-j;
                                repeat
                                        if x=0 then break;
                                        swap(pos[x,p1],pos[x,p2]);
                                        x:=pos[x,p2];
                                        swap(p1,p2);
                                until false;
                                pos[i,k]:=-j;
                        end;
                end;
        for i:=1 to m do
                for k:=1 to mdeg do
                        res[i,-pos[i,k]]:=k;
        writeln(mdeg);
        for i:=1 to m do
                for j:=1 to n do
                        if a[i,j]=1 then writeln(i,' ',j,' ',res[i,j]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
