Const   ginp='annicake.inp';
        gout='annicake.out';
        maxn=100001;

Var     n,mt,nheap,res:longint;
        sum:int64;
        x,t,heap:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j,tt,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        tt:=x[random(r-l+1)+l];
        repeat
                while x[i]<tt do inc(i);
                while x[j]>tt do dec(j);
                if i<=j then
                begin
                        tmp:=x[i]; x[i]:=x[j]; x[j]:=tmp;
                        tmp:=t[i]; t[i]:=t[j]; t[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Push(x:longint);
Var     i,j:longint;
Begin
        sum:=sum+x;
        inc(nheap);
        i:=nheap;
        while i>1 do
        begin
                j:=i shr 1;
                if heap[j]>=x then break;
                heap[i]:=heap[j];
                i:=j;
        end;
        heap[i]:=x;
End;

Procedure Pop;
Var     i,j,x:longint;
Begin
        sum:=sum-heap[1];
        x:=heap[nheap]; dec(nheap);
        i:=1;
        while i*2<=nheap do
        begin
                j:=i*2;
                if (j<nheap) and (heap[j+1]>heap[j]) then inc(j);
                if heap[j]<=x then break;
                heap[i]:=heap[j];
                i:=j;
        end;
        heap[i]:=x;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,mt);
        for i:=1 to n do readln(x[i],t[i]);
        sort(1,n);
End;

Procedure Process;
Var     i:longint;

        Function Max(x,y:longint):longint;
        Begin
                if x>y then max:=x else max:=y;
        End;

Begin
        nheap:=0; res:=0; sum:=0;
        x[0]:=0; x[n+1]:=0;
        i:=1;
        while i<=n+1 do
        begin
                if x[i-1]>mt then break;
                if x[i]<>x[i-1] then
                begin
                        while sum+x[i-1]>mt do pop;
                        res:=max(res,nheap);
                end;
                push(t[i]);
                inc(i);
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
