Const   ginp='dwall.inp';
        gout='dwall.out';
        maxn=1001;
        dd:array[1..4,1..2] of longint =((-1,0),(0,1),(1,0),(0,-1));

Var     m,n,maxp,cou,res,rx1,ry1,rx2,ry2:longint;
        d:array[0..maxn,0..maxn,1..4] of boolean;
        id:array[0..maxn,0..maxn] of longint;
        p:array[0..maxn*maxn] of longint;

Procedure Dfs(i,j:longint);
Var     i0,j0,k:longint;
Begin
        inc(p[cou]);
        id[i,j]:=cou;
        for k:=1 to 4 do
        begin
                i0:=i+dd[k,1]; j0:=j+dd[k,2];
                if (d[i,j,k]) and (i0>0) and (i0<=m) and (j0>0) and (j0<=n) and (id[i0,j0]=0)
                then dfs(i0,j0);
        end;
End;

Procedure Enter;
Var     t,x1,y1,x2,y2,i,j:longint;
Begin
        readln(m,n);
        fillchar(d,sizeof(d),true);
        while not seekeof do
        begin
                readln(x1,y1,x2,y2);
                if (x1>x2) or (y1>y2) then
                begin
                        t:=x1; x1:=x2; x2:=t;
                        t:=y1; y1:=y2; y2:=t;
                end;
                if x1=x2 then
                begin
                        d[x1,y1,2]:=false;
                        d[x2,y2,4]:=false;
                end else
                begin
                        d[x1,y1,3]:=false;
                        d[x2,y2,1]:=false;
                end;
        end;
        cou:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if id[i,j]=0 then
                        begin
                                inc(cou);
                                dfs(i,j);
                        end;
End;

Procedure Process;
Var     i,j,k,i0,j0,sum:longint;
Begin
        maxp:=0; res:=0;
        for i:=1 to cou do
                if maxp<p[i] then maxp:=p[i];
        for i:=1 to m do
        for j:=1 to n do
                for k:=2 to 3 do
                        if not d[i,j,k] then
                        begin
                                i0:=i+dd[k,1]; j0:=j+dd[k,2];
                                sum:=p[id[i,j]]+p[id[i0,j0]];
                                if id[i0,j0]=id[i,j] then sum:=sum div 2;
                                if sum>res then
                                begin
                                        res:=sum;
                                        rx1:=i; ry1:=j;
                                        rx2:=i0; ry2:=j0;
                                end;
                        end;
        writeln(cou);
        writeln(maxp);
        writeln(rx1,' ',ry1,' ',rx2,' ',ry2);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
