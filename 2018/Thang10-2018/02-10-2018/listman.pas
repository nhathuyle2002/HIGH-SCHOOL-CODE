Const   ginp='listman.inp';
        gout='listman.out';
        oo=trunc(1e9)+100;
        maxn=100010;

Var     n,q,nheap:longint;
        pos,heap,a:array[0..maxn] of longint;

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
        if a[heap[i]]<a[heap[j]] then
        begin
                swap(heap[i],heap[j]);
                swap(pos[heap[i]],pos[heap[j]]);
                upheap(j);
        end;
End;

Procedure Downheap(i:longint);
Var     j:longint;
Begin
        j:=i shl 1;
        if j>nheap then exit;
        if (j<nheap) and (a[heap[j+1]]<a[heap[j]]) then inc(j);
        if (a[heap[i]]>a[heap[j]]) then
        begin
                swap(heap[i],heap[j]);
                swap(pos[heap[i]],pos[heap[j]]);
                downheap(j);
        end;
End;

Procedure Update(i:longint);
Begin
        if a[i]<=0 then a[i]:=oo;
        if pos[i]=0 then
        begin
                inc(nheap);
                pos[i]:=nheap;
                heap[nheap]:=i;
        end;
        upheap(pos[i]); downheap(pos[i]);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,q);
        for i:=1 to n do
        begin
                read(a[i]);
                update(i);
        end;
        readln;
End;

Procedure Process;
Var     i,v:longint;
        ms:string[1];
Begin
        for i:=1 to q do
        begin
                read(ms);
                if ms='S' then
                begin
                        read(v); read(a[v]);
                        update(v);
                end else
                begin
                        if a[heap[1]]=oo then writeln(0)
                        else writeln(a[heap[1]]);
                end;
                readln;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
