Const   ginp='querymin.inp';
        gout='querymin.out';
        maxn=100010;
        oo=trunc(1e9)+100;

Var     n,m,nheap:longint;
        heap,d,pos:array[0..maxn] of longint;

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
        if d[heap[i]]<d[heap[j]] then
        begin
                swap(pos[heap[i]],pos[heap[j]]);
                swap(heap[i],heap[j]);
                upheap(j);
        end;
End;

Procedure Downheap(i:longint);
Var     j:longint;
Begin
        j:=i*2;
        if j>nheap then exit;
        if (j<nheap) and (d[heap[j+1]]<d[heap[j]]) then inc(j);
        if d[heap[i]]>d[heap[j]] then
        begin
                swap(pos[heap[i]],pos[heap[j]]);
                swap(heap[i],heap[j]);
                downheap(j);
        end;
End;

Procedure Update(ii,x:longint);
Var     i,j:longint;
Begin
        if x<=0 then x:=oo;
        d[ii]:=x;
        if pos[ii]=0 then
        begin
                inc(nheap);
                heap[nheap]:=ii;
                pos[ii]:=nheap;
        end;
        upheap(pos[ii]);
        downheap(pos[ii]);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to n do
        begin
                d[i]:=0; pos[i]:=0;
        end;
        nheap:=0;
End;

Procedure Process;
Var     i,ii,x:longint;
        ms:string[3];
Begin
        for i:=1 to m do
        begin
                read(ms);
                if ms='AGN' then
                begin
                        read(ii,x);
                        update(ii,x);
                end else
                begin
                        if (nheap<1) or (d[heap[1]]=oo) then writeln(0) else writeln(d[heap[1]]);
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
