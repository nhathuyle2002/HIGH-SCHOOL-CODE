Const   ginp='water.inp';
        gout='water.out';
        maxn=1001;
        maxh=1000000;
        dx:array[1..4] of longint =(-1,1,0,0);
        dy:array[1..4] of longint =(0,0,-1,1);

Type    point =record x,y:longint; end;

Var     m,n,nheap,cou:longint;
        res:int64;
        a:array[0..maxn,0..maxn] of longint;
        dh:array[0..maxh] of longint;
        dp:array[0..maxn,0..maxn] of boolean;
        heap:array[0..maxn*maxn] of point;

Procedure Push(x,y:longint);
Var     i,j:longint;
Begin
        if not dp[x,y] then exit;
        dp[x,y]:=false;
        inc(nheap); i:=nheap;
        repeat
                j:=i shr 1;
                if (j<1) or (a[heap[j].x,heap[j].y]<=a[x,y]) then break;
                heap[i]:=heap[j];
                i:=j;
        until false;
        heap[i].x:=x; heap[i].y:=y;
End;

Function Pop:point;
Var     i,j,hh:longint;
Begin
        pop:=heap[1]; dec(cou);
        hh:=a[heap[nheap].x,heap[nheap].y]; dec(nheap);
        i:=1;
        repeat
                j:=i shl 1;
                if (j<nheap) and (a[heap[j].x,heap[j].y]>a[heap[j+1].x,heap[j+1].y]) then inc(j);
                if (j>nheap) or (a[heap[j].x,heap[j].y]>=hh) then break;
                heap[i]:=heap[j];
                i:=j;
        until false;
        heap[i]:=heap[nheap+1];
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        inc(dh[a[i,j]]);
                end;
                readln;
        end;
        fillchar(dp,sizeof(dp),true);
        nheap:=0;
        for i:=1 to m do
        begin
                dp[i,0]:=false; dp[i,n+1]:=false;
                push(i,1); push(i,n);
        end;
        for j:=1 to n do
        begin
                dp[0,j]:=false; dp[m+1,j]:=false;
                push(1,j); push(m,j);
        end;
End;

Procedure Process;
Var     high,k:longint;
        u:point;
Begin
        res:=0; cou:=0;
        for high:=1 to maxh do
        begin
                if nheap=0 then break;
                cou:=cou+dh[high];
                while (nheap>0) and (a[heap[1].x,heap[1].y]<=high) do
                begin
                        u:=pop;
                        for k:=1 to 4 do push(u.x+dx[k],u.y+dy[k]);
                end;
                res:=res+cou;
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
