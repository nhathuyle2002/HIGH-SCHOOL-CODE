Const   ginp='wifi.inp';
        gout='wifi.out';
        maxn=501;
        di:array[1..4] of longint =(-1,1,0,0);
        dj:array[1..4] of longint =(0,0,-1,1);

Type    save= record i,j:longint; end;

Var     m,n,l,r,couid,couedge:longint;
        dq:array[0..maxn*maxn] of save;
        root:array[0..maxn*maxn] of longint;
        trace:array[0..maxn,0..maxn] of save;
        id:array[0..maxn,0..maxn] of longint;
        a:array[0..maxn] of ansistring;

Function Checkin(i,j:longint):boolean;
Begin
        if (i<1) or (i>m) or (j<1) or (j>n) then exit(false) else exit(true);
End;

Function Pop:save;
Begin
        pop:=dq[l]; inc(l);
End;

Procedure Push(i,j,i0,j0,iid:longint);
Begin
        id[i,j]:=iid;
        trace[i,j].i:=i0; trace[i,j].j:=j0;
        inc(r);
        dq[r].i:=i; dq[r].j:=j;
End;

Procedure Dfs(i,j:longint);
Var     k,i0,j0:longint;
Begin
        push(i,j,0,0,couid);
        for k:=1 to 4 do
        begin
                i0:=i+di[k]; j0:=j+dj[k];
                if checkin(i0,j0) and (id[i0,j0]=0) and (a[i0,j0]='*') then dfs(i0,j0);
        end;
End;

Function Find_Root(u:longint):longint;
Begin
        while root[u]<>u do u:=root[u];
        find_root:=u;
End;

Procedure Tick(i,j:longint);
Begin
        if (i=0) or (a[i,j]='*') then exit;
        a[i,j]:='*';
        tick(trace[i,j].i,trace[i,j].j);
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n);
        for i:=1 to m do readln(a[i]);
        couid:=0; l:=1; r:=0;
        for i:=1 to m do
                for j:=1 to n do
                begin
                        inc(couid);
                        if (a[i,j]='*') and (id[i,j]=0) then dfs(i,j);
                end;
End;

Procedure Bfs_Prime;
Var     i,j,k,x,y:longint;
        u:save;
Begin
        if couid<=1 then exit;
        for i:=1 to couid do root[i]:=i;
        couedge:=0;
        repeat
                u:=pop;
                for k:=1 to 4 do
                begin
                        i:=u.i+di[k]; j:=u.j+dj[k];
                        if not checkin(i,j) then continue;
                        if id[i,j]=0 then push(i,j,u.i,u.j,id[u.i,u.j]) else
                        begin
                                x:=find_root(id[u.i,u.j]); y:=find_root(id[i,j]);
                                if x<>y then
                                begin
                                        tick(u.i,u.j); tick(i,j);
                                        inc(couedge);
                                        if couedge=couid-1 then exit;
                                end;
                        end;
                end;
        until l>r;
End;

Procedure Answer;
Var     i,j:longint;
Begin
        for i:=1 to m do
        begin
                for j:=1 to n do write(a[i,j]);
                writeln;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Bfs_Prime;
        Answer;
        Close(input); Close(output);
End.
