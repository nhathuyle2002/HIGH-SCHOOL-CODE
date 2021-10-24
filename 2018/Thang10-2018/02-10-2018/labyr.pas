Type    point= record i,j:longint; end;

Const   ginp='labyr.inp';
        gout='labyr.out';
        maxn=1001;
        di:array[1..4] of longint= (-1,1,0,0);
        dj:array[1..4] of longint= (0,0,-1,1);

Var     m,n,l,r,cou:longint;
        a:array[0..maxn] of ansistring;
        q,ou:array[0..maxn*maxn] of point;
        trace:array[0..maxn,0..maxn] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        fillchar(trace,sizeof(trace),0);
        l:=0; r:=1;
        readln(m,n);
        for i:=1 to m do
        begin
                readln(a[i]);
                for j:=1 to n do
                        if a[i,j]='E' then
                        begin
                                trace[i,j]:=-1;
                                q[1].i:=i; q[1].j:=j;
                        end;
        end;
End;

Function Check(i,j:longint):boolean;
Begin
        if (i<1) or (i>m) or (j<1) or (j>n) then exit(false);
        if (trace[i,j]<>0) or (a[i,j]='X') then exit(false);
        exit(true);
End;

Procedure Try(i,j:longint);
Begin
        inc(cou);
        ou[cou].i:=i; ou[cou].j:=j;
        if trace[i,j]=-1 then exit;
        try(i-di[trace[i,j]], j-dj[trace[i,j]]);
End;

Procedure Process;
Var     k,i0,j0:longint;
Begin
        repeat
                inc(l);
                if (q[l].i=1) or (q[l].i=m) or (q[l].j=1) or (q[l].j=n) then
                begin
                        try(q[l].i,q[l].j);
                        writeln(cou);
                        for k:=cou downto 1 do writeln(ou[k].i,' ',ou[k].j);
                        break;
                end;
                for k:=1 to 4 do
                begin
                        i0:=q[l].i+di[k]; j0:=q[l].j+dj[k];
                        if check(i0,j0) then
                        begin
                                trace[i0,j0]:=k;
                                inc(r);
                                q[r].i:=i0; q[r].j:=j0;
                        end;
                end;
                if l>=r then
                begin
                        write(-1);
                        break;
                end;
        until false;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
