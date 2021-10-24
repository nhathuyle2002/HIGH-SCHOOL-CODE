Const   ginp='line2.inp';
        gout='line2.out';
        oo=trunc(1e4)+10;
        maxn=101;
        di:array[1..8] of longint= (-2,-2,-1,1,2,2,1,-1);
        dj:array[1..8] of longint= (-1,1,2,2,1,-1,-2,-2);

Var     m,n,nn:longint;
        a:array[0..maxn] of string;
        w:array[0..maxn,0..maxn,0..maxn] of longint;
        d:array[0..maxn,0..maxn] of boolean;
        mx,my,trace:array[0..maxn] of longint;

Procedure Bfs(i,j:longint);
Var     l,r,k:longint;
        qi,qj:array[0..maxn*maxn] of longint;
        d:array[0..maxn,0..maxn] of longint;
Begin
        fillchar(d,sizeof(d),0);
        d[i,j]:=1;
        l:=1; r:=1; qi[1]:=i; qj[1]:=j;
        repeat
                for k:=1 to 8 do
                begin
                        i:=qi[l]+di[k];
                        j:=qj[l]+dj[k];
                        if (i>0) and (j>0) and (i<=m) and (j<=n) and (d[i,j]=0) and (a[i,j]<>'#') then
                        begin
                                d[i,j]:=d[qi[l],qj[l]]+1;
                                inc(r);
                                qi[r]:=i; qj[r]:=j;
                        end;
                end;
                inc(l);
        until l>r;
        for i:=1 to m do
                for j:=1 to n do
                        if d[i,j]=0 then w[nn,i,j]:=oo else w[nn,i,j]:=d[i,j]-1;
End;

Procedure Init(i,jj,maxw:longint);
Var     ii,j:longint;
Begin
        for ii:=1 to nn do
                for j:=1 to n do
                        if (w[ii,i,j]<=maxw) and (j>=jj) and (j<=jj+nn-1) then d[ii,j]:=true else d[ii,j]:=false;
        for ii:=1 to nn do mx[ii]:=0;
        for j:=1 to n do my[j]:=0;
End;

Function FindPath:longint;
Var     x,y,l,r:longint;
        q:array[0..maxn] of longint;
Begin
        for y:=1 to n do trace[y]:=0;
        l:=1; r:=0;
        for x:=1 to nn do
                if mx[x]=0 then
                begin
                        inc(r); q[r]:=x;
                end;
        repeat
                x:=q[l]; inc(l);
                for y:=1 to n do
                        if (trace[y]=0) and (d[x,y]) and (my[y]<>x) then
                        begin
                                trace[y]:=x;
                                if my[y]=0 then exit(y);
                                inc(r); q[r]:=my[y];
                        end;
        until l>r;
        exit(0);
End;

Procedure IncFlow(t:longint);
Var     x,t2:longint;
Begin
        repeat
                x:=trace[t];
                t2:=mx[x];
                mx[x]:=t; my[t]:=x;
                t:=t2;
        until t=0;
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n);
        for i:=1 to m do readln(a[i]);
        nn:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if a[i,j]='M' then
                        begin
                                inc(nn);
                                bfs(i,j);
                        end;
End;

Procedure Process;
Var     i,j,y,l,r,mid,cou:longint;
Begin
        l:=0; r:=oo;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                for i:=1 to m do
                begin
                        for j:=1 to n-nn+1 do
                        begin
                                init(i,j,mid);
                                cou:=0;
                                repeat
                                        y:=findpath;
                                        if y<>0 then
                                        begin
                                                incflow(y);
                                                inc(cou);
                                        end;
                                until y=0;
                                if cou=nn then break;
                        end;
                        if cou=nn then break;
                end;
                if cou<nn then l:=mid+1 else r:=mid;
        end;
        write(l);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.