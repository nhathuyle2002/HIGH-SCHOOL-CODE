Const   ginp='cd.inp';
        gout='cd.out';
        maxn=201;

Var     n,w,nheap:longint;
        a,pl,pr,f:array[0..2*maxn] of longint;
        d:array of array of boolean;
        pos,res,heap:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
VAr     i,j,t,tmp:longint;
Begin
        if l>r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        tmp:=pos[i]; pos[i]:=pos[j]; pos[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Push(ii:longint);
Var     i,j:longint;
Begin
        inc(nheap);
        i:=nheap;
        while i>1 do
        begin
                j:=i shr 1;
                if a[heap[j]]>=a[ii] then break;
                heap[i]:=heap[j];
                i:=j;
        end;
        heap[i]:=ii;
End;

Function Pop:longint;
Var     i,j,ii:longint;
Begin
        pop:=heap[1];
        ii:=heap[nheap]; dec(nheap);
        i:=1;
        while i shl 1<=nheap do
        begin
                j:=i shl 1;
                if (j<nheap) and (a[heap[j+1]]>a[heap[j]]) then inc(j);
                if a[heap[j]]<=a[ii] then break;
                heap[i]:=heap[j];
                i:=j;
        end;
        heap[i]:=ii;
End;

Function Check(nn:longint):boolean;
Var     i,x,y:longint;
        sum:int64;
Begin
        nheap:=0; sum:=0;
        for i:=1 to nn do
        begin
                sum:=sum+a[i];
                push(i);
        end;
        for i:=1 to nn-1 do
        begin
                x:=pop; y:=pop;
                a[n+i]:=a[x]-a[y]; push(n+i);
        end;
        x:=pop;
        sum:=(sum+a[x]) div 2;
        if sum<=w then exit(true) else exit(false);
End;

Procedure Dfs(u,x:longint);
Begin
        f[u]:=x;
        if pl[u]>0 then dfs(pl[u],x);
        if pr[u]>0 then dfs(pr[u],1-x);
End;

Procedure Answ(nn:longint);
Var     i,x,y:longint;
Begin
        filldword(pl[1],2*n,0);
        filldword(pr[1],2*n,0);
        nheap:=0;
        for i:=1 to nn do push(i);
        for i:=1 to nn-1 do
        begin
                x:=pop; y:=pop;
                pl[n+i]:=x; pr[n+i]:=y;
                a[n+i]:=a[x]-a[y]; push(n+i);
        end;
        filldword(f[1],2*n,2);
        x:=pop;
        dfs(x,0);
        for i:=1 to n do res[pos[i]]:=2-f[i];
End;

Procedure Tvan(i,j:longint);
Begin
        if i=0 then exit;
        if d[i-1,j] then
        begin
                res[pos[i]]:=2;
                tvan(i-1,j);
        end else
        if d[i-1,j-a[i]] then
        begin
                res[pos[i]]:=1;
                tvan(i-1,j-a[i]);
        end;

End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,w);
        for i:=1 to n do
        begin
                read(a[i]);
                pos[i]:=i;
        end;
        sort(1,n);
End;

Procedure Process1;
Var     i,l,r,mid:longint;
Begin
        l:=1; r:=n+1;
        while l<r do
        begin
                mid:=(l+r) shr 1;
                if check(mid) then l:=mid+1 else r:=mid;
        end;
        Answ(l-1);
        for i:=1 to n do write(res[i],' ');
End;

Procedure Process2;
Var     i,j:longint;
        ok:boolean;
        sum:array[0..maxn] of int64;
Begin
        sum[0]:=0;
        for i:=1 to n do sum[i]:=sum[i-1]+a[i];
        setlength(d,n+1);
        setlength(d[0],w+1);
        d[0,0]:=true;
        for j:=1 to w do d[0,j]:=false;
        for i:=1 to n do
        begin
                setlength(d[i],w+1);
                for j:=0 to w do
                        if (d[i-1,j]) and (sum[i]-j<=w) then d[i,j]:=true else
                        if (j-a[i]>=0) and (d[i-1,j-a[i]]) then d[i,j]:=true else
                        d[i,j]:=false;
        end;
        filldword(res[1],n,0);
        ok:=false;
        for i:=n downto 1 do
        begin
                for j:=0 to w do
                        if d[i,j] then
                        begin
                                ok:=true;
                                Tvan(i,j);
                                break;
                        end;
                if ok then break;
        end;
        for i:=1 to n do write(res[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        if int64(w)*n>5*trunc(1e7) then process1 else process2;
        Close(input); Close(output);
End.
