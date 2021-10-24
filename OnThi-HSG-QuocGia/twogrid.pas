Const   ginp='twogrid.inp';
        gout='twogrid.out';
        maxn=1001;
        dx:array[1..4] of longint = (-1,0,0,1);
        dy:array[1..4] of longint = (0,-1,1,0);

Var     m,n,res1,res2,res3:longint;
        x1,y1,x2,y2:longint;
        a,b,c:array[0..maxn] of ansistring;
        d:array[0..maxn,0..maxn] of longint;
        l,r:longint;
        qx,qy:array[0..maxn*maxn] of longint;

Function Check(i,j:longint):boolean;
Begin
        if (i<1) or (j<1) or (i>m) or (j>n) then exit(false);
        if (a[i,j]='#') or (d[i,j]>0) then exit(false);
        exit(true);
End;

Function Pc:longint;
Var     i,j,x0,y0:longint;
Begin
        for i:=1 to m do
                for j:=1 to n do d[i,j]:=0;
        l:=1; r:=1; qx[1]:=x1; qy[1]:=y1;
        d[x1,y1]:=1;
        repeat
                for i:=1 to 4 do
                begin
                        x0:=qx[l]+dx[i];
                        y0:=qy[l]+dy[i];
                        if check(x0,y0) then
                        begin
                                d[x0,y0]:=d[qx[l],qy[l]]+1;
                                if (x0=x2) and (y0=y2) then break;
                                inc(r);
                                qx[r]:=x0; qy[r]:=y0;
                        end;
                end;
                inc(l);
        until (l>r) or (d[x2,y2]>0);
        if d[x2,y2]=0 then pc:=-1 else pc:=d[x2,y2];
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n);
        for i:=1 to m do
        begin
                readln(a[i]);
                for j:=1 to n do
                        if a[i,j]='S' then
                        begin
                                x1:=i; y1:=j;
                        end else
                        if a[i,j]='F' then
                        begin
                                x2:=i; y2:=j;
                        end;
        end;
        for i:=1 to m do readln(b[i]);
End;

Procedure Process;
Var     i,j:longint;
Begin
        res1:=pc;
        c:=a; a:=b; b:=c;
        res2:=pc;
        for i:=1 to m do
                for j:=1 to n do
                        if b[i,j]='#' then a[i,j]:='#';
        res3:=pc;
        if (res1=res2) and (res2=res3) and (res1<>-1) then write(res1-2) else write(-1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
