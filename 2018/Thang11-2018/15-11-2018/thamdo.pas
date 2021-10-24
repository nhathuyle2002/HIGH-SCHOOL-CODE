Const   ginp='thamdo.inp';
        gout='thamdo.out';
        maxn=1001;
        di:array[1..4] of longint =(-1,1,0,0);
        dj:array[1..4] of longint =(0,0,-1,1);

Var     m,n,k,res:longint;
        s:array[0..maxn,0..maxn] of longint;
        d:array[0..maxn,0..maxn] of boolean;

Function Get(i,j:longint):longint;
Begin
        get:=s[i,j]-s[i-k,j]-s[i,j-k]+s[i-k,j-k];
End;

Function Check(i,j:longint):boolean;
Begin
        if (i<k) or (j<k) or (i>m) or (j>n) then exit(false);
        if (get(i,j)<>0) or (not d[i,j]) then exit(false);
        exit(true);
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n,k);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(s[i,j]);
                        s[i,j]:=s[i-1,j]+s[i,j-1]-s[i-1,j-1]+s[i,j];
                end;
                readln;
        end;
End;

Procedure Dfs(i0,j0:longint);
Var     kk,i,j:longint;
Begin
        d[i0,j0]:=false;
        for kk:=1 to 4 do
        begin
                i:=i0+di[kk]; j:=j0+dj[kk];
                if check(i,j) then dfs(i,j);
        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        fillchar(d,sizeof(d),true);
        res:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if check(i,j) then
                        begin
                                inc(res);
                                dfs(i,j);
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
