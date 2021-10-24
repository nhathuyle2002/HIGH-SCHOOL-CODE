Uses    Math;

Const   ginp='indep.inp';
        gout='indep.out';
        maxn=1000010;

Var     n:longint;
        s:ansistring;
        p1,p2:array[0..maxn] of longint;
        f:array[0..maxn,0..1,0..1] of longint;

Procedure Dfs(u:longint);
Begin
        if s[u]='g' then
        begin
                f[u,0,0]:=0;
                f[u,0,1]:=1;
                f[u,1,0]:=1;
                f[u,1,1]:=0;
                exit;
        end;
        dfs(p1[u]); dfs(p2[u]);
        if s[u]='S' then
        begin
                f[u,0,0]:=max(f[p1[u],0,1]+f[p2[u],1,0]-1,f[p1[u],0,0]+f[p2[u],0,0]);
                f[u,0,1]:=max(f[p1[u],0,1]+f[p2[u],1,1]-1,f[p1[u],0,0]+f[p2[u],0,1]);
                f[u,1,0]:=max(f[p1[u],1,0]+f[p2[u],0,0],f[p1[u],1,1]+f[p2[u],1,0]-1);
                f[u,1,1]:=max(f[p1[u],1,0]+f[p2[u],0,1],f[p1[u],1,1]+f[p2[u],1,1]-1);
        end else
        if s[u]='P' then
        begin
                f[u,0,0]:=f[p1[u],0,0]+f[p2[u],0,0];
                f[u,0,1]:=f[p1[u],0,1]+f[p2[u],0,1]-1;
                f[u,1,0]:=f[p1[u],1,0]+f[p2[u],1,0]-1;
                f[u,1,1]:=f[p1[u],1,1]+f[p2[u],1,1]-2;
        end;
End;

Procedure Enter;
Var     i,top:longint;
        q,typ:array[0..maxn] of longint;
Begin
        read(s); n:=length(s);
        top:=0; q[0]:=0; typ[0]:=0;
        for i:=1 to n do
        begin
                if typ[top]=0 then p1[q[top]]:=i else p2[q[top]]:=i;
                dec(top);
                if s[i]<>'g' then
                begin
                        inc(top); q[top]:=i; typ[top]:=1;
                        inc(top); q[top]:=i; typ[top]:=0;
                end;
        end;
End;

Procedure Process;
Begin
        dfs(1);
        write(max(max(f[1,0,0],f[1,0,1]),max(f[1,1,0],f[1,1,1])));
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
