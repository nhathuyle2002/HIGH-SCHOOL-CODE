Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';
        maxn=100001;
        oo=trunc(1e9)+100;

Var     n:longint;
        w,h,l,r:array[0..maxn] of longint;
        sum:int64;
        res:array[0..maxn] of int64;
        nheap:longint;
        heap,d:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(w[i],h[i]);
        w[0]:=0; h[0]:=oo;
        w[n+1]:=0; h[n+1]:=oo;
        for i:=1 to n do w[i]:=w[i]+w[i-1];
End;

Procedure Init;
Var     i,top:longint;
        q:array[0..maxn] of longint;
Begin
        top:=0; q[0]:=0;
        for i:=1 to n do
        begin
                r[i]:=n+1;
                while h[i]>h[q[top]] do
                begin
                        r[q[top]]:=i;
                        dec(top);
                end;
                l[i]:=q[top];
                inc(top); q[top]:=i;
        end;
End;

Procedure Swap(var x,y:longint);
Var     tmp:longint;
Begin
        tmp:=x; x:=y; y:=tmp;
End;

Procedure Upheap(i:longint);
Var     j:longint;
Begin
        j:=i shr 1;
        if j<1 then exit;
        if h[heap[i]]<h[heap[j]] then
        begin
                swap(heap[i],heap[j]);
                upheap(j);
        end;
End;

Procedure Downheap(i:longint);
Var     j:longint;
Begin
        j:=i shl 1;
        if j>nheap then exit;
        if (j<nheap) and (h[heap[j+1]]<h[heap[j]]) then inc(j);
        if h[heap[j]]<h[heap[i]] then
        begin
                swap(heap[i],heap[j]);
                downheap(j);
        end;
End;

Procedure Push(i:longint);
Begin
        d[i]:=1;
        inc(nheap);
        heap[nheap]:=i;
        upheap(nheap);
End;

Function Pop:longint;
Begin
        while (heap[1]>1) and (d[heap[1]-1]=0) and (h[heap[1]-1]<h[heap[1]]) do push(heap[1]-1);
        while (heap[1]<n) and (d[heap[1]+1]=0) and (h[heap[1]+1]<h[heap[1]]) do push(heap[1]+1);
        pop:=heap[1];
        heap[1]:=heap[nheap];
        dec(nheap);
        downheap(1);
End;

Procedure Process;
Var     i,st:longint;
Begin
        st:=0;
        for i:=1 to n do
        begin
                d[i]:=0;
                if h[i]<h[st] then st:=i;
        end;
        sum:=0;
        push(st);
        repeat
                i:=pop;
                res[i]:=sum+w[r[i]-1]-w[l[i]];
                sum:=sum+int64(min(h[l[i]],h[r[i]])-h[i])*(w[r[i]-1]-w[l[i]]);
                if (i>1) and (d[i-1]=0) then push(i-1);
                if (i<n) and (d[i+1]=0) then push(i+1);
        until nheap=0;
        for i:=1 to n do writeln(res[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        Process;
        Close(input); Close(output);
End.
