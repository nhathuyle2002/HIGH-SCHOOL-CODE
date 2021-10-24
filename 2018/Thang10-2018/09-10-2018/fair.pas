Type    saveheap= record i,j:longint; end;

Const   ginp='fair.inp';
        gout='fair.out';
        maxn=1001;
        oo=trunc(1e9);
        di:array[1..4] of longint =(-1,1,0,0);
        dj:array[1..4] of longint =(0,0,-1,1);

Var     m,n,mk,nheap,cou:longint;
        heap,ou:array[0..maxn*maxn] of saveheap;
        a,pos,f:array[0..maxn,0..maxn] of longint;
        trace:array[0..maxn,0..maxn] of saveheap;

Function Cmp(i,j:longint):boolean; inline;
Begin
        cmp:=f[heap[i].i,heap[i].j]<f[heap[j].i,heap[j].j];
End;

Function Checkin(i,j:longint):boolean; inline;
Begin
        if (i<1) or (i>m) or (j<1) or (j>n) then exit(false) else exit(true);
End;

Procedure Swap(i,j:longint); inline;
Var     tmp:longint;
        tt:saveheap;
Begin
        tmp:=pos[heap[i].i,heap[i].j];
        pos[heap[i].i,heap[i].j]:=pos[heap[j].i,heap[j].j];
        pos[heap[j].i,heap[j].j]:=tmp;
        tt:=heap[i]; heap[i]:=heap[j]; heap[j]:=tt;
End;

Procedure Update(x,y:longint);
Var     i,j:longint;
Begin
        if pos[x,y]=0 then
        begin
                inc(nheap);
                heap[nheap].i:=x; heap[nheap].j:=y;
                pos[x,y]:=nheap;
        end;
        i:=pos[x,y];
        while i>1 do
        begin
                j:=i shr 1;
                if cmp(i,j) then swap(i,j) else break;
                i:=j;
        end;
End;

Function Pop:saveheap;
Var     i,j:longint;
Begin
        pop:=heap[1];
        swap(1,nheap); dec(nheap);
        i:=1;
        while i shl 1<=nheap do
        begin
                j:=i shl 1;
                if (j<nheap) and (cmp(j+1,j)) then inc(j);
                if cmp(j,i) then swap(i,j) else break;
                i:=j;
        end;
End;

Procedure Answer(i,j:longint);
Begin
        if i=0 then exit;
        inc(cou); ou[cou].i:=i; ou[cou].j:=j;
        answer(trace[i,j].i,trace[i,j].j);
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n,mk);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
End;

Procedure Cndb(i,j,i0,j0:longint);
Begin
        if (checkin(i,j)) and (f[i,j]>f[i0,j0]) then
        begin
                f[i,j]:=f[i0,j0];
                trace[i,j].i:=i0; trace[i,j].j:=j0;
                update(i,j);
        end;
End;

Procedure Process;
Var     i,j,ij,ki,kj:longint;
        u:saveheap;
Begin
        for i:=1 to m do
                for j:=2 to n do f[i,j]:=oo;
        nheap:=0;
        for i:=1 to m do
        begin
                f[i,1]:=a[i,1];
                update(i,1);
        end;
        repeat
                u:=pop;
                if u.j=n then break;
                if a[u.i,u.j]>0 then
                for ij:=1 to 4 do
                begin
                        i:=u.i+di[ij]; j:=u.j+dj[ij];
                        if (checkin(i,j)) and (f[u.i,u.j]+a[i,j]<f[i,j]) then
                        begin
                                f[i,j]:=f[u.i,u.j]+a[i,j];
                                trace[i,j].i:=u.i; trace[i,j].j:=u.j;
                                update(i,j);
                        end;
                end else
                for ki:=0 to mk do
                for kj:=0 to mk-ki do
                begin
                        cndb(u.i-ki,u.j-kj,u.i,u.j);
                        cndb(u.i-ki,u.j+kj,u.i,u.j);
                        cndb(u.i+ki,u.j-kj,u.i,u.j);
                        cndb(u.i+ki,u.j+kj,u.i,u.j);
                end;
        until false;
        writeln(f[u.i,u.j]);
        cou:=0; answer(u.i,u.j);
        for ij:=cou downto 2 do
        begin
                while ou[ij].i<ou[ij-1].i do
                begin
                        writeln(ou[ij].i,' ',ou[ij].j);
                        inc(ou[ij].i);
                end;
                while ou[ij].i>ou[ij-1].i do
                begin
                        writeln(ou[ij].i,' ',ou[ij].j);
                        dec(ou[ij].i);
                end;
                while ou[ij].j<ou[ij-1].j do
                begin
                        writeln(ou[ij].i,' ',ou[ij].j);
                        inc(ou[ij].j);
                end;
                while ou[ij].j>ou[ij-1].j do
                begin
                        writeln(ou[ij].i,' ',ou[ij].j);
                        dec(ou[ij].j);
                end;
        end;
        write(ou[1].i,' ',ou[1].j);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
