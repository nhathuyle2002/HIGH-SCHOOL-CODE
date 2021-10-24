Const   ginp='power.inp';
        gout='power.out';

Var     n,k,nheap:longint;
        res:int64;
        x,y,heap:array[0..200010] of longint;

Procedure Swap(var xx,yy:longint);
Var     tmp:longint;
Begin
        tmp:=xx; xx:=yy; yy:=tmp;
End;

Procedure Sort(l,r:longint);
Var     i,j,t:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=x[random(r-l+1)+l];
        repeat
                while x[i]<t do inc(i);
                while x[j]>t do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]); swap(y[i],y[j]);
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Push(x:longint);
Var     i,j:longint;
Begin
        inc(nheap);
        i:=nheap;
        repeat
                j:=i shr 1;
                if (j<1) or (x>=heap[j]) then break;
                heap[i]:=heap[j];
                i:=j;
        until false;
        heap[i]:=x;
End;

Procedure Pop;
Var     i,j,x:longint;
Begin
        x:=heap[nheap]; dec(nheap);
        i:=1;
        repeat
                j:=i shl 1;
                if (j<nheap) and (heap[j]>heap[j+1]) then inc(j);
                if (j>nheap) or (x<=heap[j]) then break;
                heap[i]:=heap[j];
                i:=j
        until false;
        heap[i]:=x;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,k);
        for i:=1 to n do readln(x[i],y[i]);
        sort(1,n);
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0; nheap:=0;
        for i:=n downto 1 do
        begin
                push(y[i]);
                if nheap<k then continue;
                if nheap>k then pop;
                if res<int64(x[i])*heap[1] then res:=int64(x[i])*heap[1];
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
