Const   ginp='guard.inp';
        gout='guard.out';
        maxn=1001;
        di:array[1..8] of longint =(-1,-1,-1,0,1,1,1,0);
        dj:array[1..8] of longint =(-1,0,1,1,1,0,-1,-1);

Var     m,n,res:longint;
        ok:boolean;
        h:array[0..maxn,0..maxn] of longint;
        d:array[0..maxn,0..maxn] of boolean;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(h[i,j]);
                readln;
        end;
End;

Function Check(i,j:longint):boolean;
Begin
        if (i<1) or (j<1) or (i>m) or (j>n) then exit(false);
        exit(true);
End;

Procedure Dfs(i,j:longint);
Var     i0,j0,k:longint;
Begin
        d[i,j]:=false;
        for k:=1 to 8 do
        begin
                i0:=i+di[k]; j0:=j+dj[k];
                if check(i0,j0) then
                begin
                        if (d[i0,j0]) and (h[i0,j0]=h[i,j]) then dfs(i0,j0);
                        if h[i0,j0]>h[i,j] then ok:=false;
                end;
        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        fillchar(d,sizeof(d),true);
        res:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if d[i,j] then
                        begin
                                ok:=true;
                                dfs(i,j);
                                if ok then inc(res);
                        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
