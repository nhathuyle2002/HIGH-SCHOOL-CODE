Const   ginp='meeting.inp';
        gout='meeting.out';
        maxn=1001;

Var     n,cou,nn,cou1,cou2:longint;
        link,y:array[-100*maxn..maxn*100] of longint;
        head,id,a1,a2:array[0..maxn] of longint;
        a:array[0..2*maxn,0..maxn] of longint;
        d:array[0..2*maxn,-maxn..maxn] of longint;

Procedure Add(i,u,v:longint);
Begin
        y[i]:=v;
        link[i]:=head[u];
        head[u]:=i;
End;

Procedure Dfs(u,k:longint);
Var     i,v:longint;
Begin
        id[u]:=cou+k;
        inc(a[cou+k,0]); a[cou+k,a[cou+k,0]]:=u;
        i:=head[u];
        while i<>0 do
        begin
                v:=y[i];
                if id[v]=0 then dfs(v,-1-k);
                i:=link[i];
        end;
End;

Procedure Answer(i,j:longint);
Begin
        if i=0 then exit;
        inc(nn);
        if d[i,j]=1 then
        begin
                a1[nn]:=i*2-1; cou1:=cou1+a[i*2-1,0];
                a2[nn]:=i*2; cou2:=cou2+a[i*2,0];
                j:=j+a[i*2-1,0]-a[i*2,0];
        end else
        begin
                a1[nn]:=i*2; cou1:=cou1+a[i*2,0];
                a2[nn]:=i*2-1; cou2:=cou2+a[i*2-1,0];
                j:=j-a[i*2-1,0]+a[i*2,0];
        end;
        answer(i-1,j);
End;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n); i:=0;
        while not seekeof do
        begin
                inc(i);
                readln(u,v);
                add(i,u,v); add(-i,v,u);
        end;
        cou:=0;
        for i:=1 to n do
                if id[i]=0 then
                begin
                        inc(cou,2);
                        dfs(i,-1);
                end;
End;

Procedure Process;
Var     i,j,j1,j2:longint;
Begin
        for j:=-n to n do d[0,j]:=0;
        d[0,0]:=1;
        for i:=1 to cou div 2 do
                for j:=-n to n do
                begin
                        j1:=j+a[i*2-1,0]-a[i*2,0]; j2:=j-a[i*2-1,0]+a[i*2,0];
                        if (j1>=-n) and (j1<=n) and (d[i-1,j1]>0) then d[i,j]:=1 else
                        if (j2>=-n) and (j2<=n) and (d[i-1,j2]>0) then d[i,j]:=2 else
                        d[i,j]:=0;
                end;
        nn:=0; cou1:=0; cou2:=0;
        for j:=0 to n do
                if d[cou div 2,j]>0 then
                begin
                        answer(cou div 2,j); break;
                end else
                if d[cou div 2,-j]>0 then
                begin
                        answer(cou div 2,-j); break;
                end;
        writeln(cou1,' ',cou2);
        for i:=1 to nn do
                for j:=1 to a[a1[i],0] do write(a[a1[i],j],' ');
        writeln;
        for i:=1 to nn do
                for j:=1 to a[a2[i],0] do write(a[a2[i],j],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
