Const   ginp='guards.inp';
        gout='guards.out';
        maxn=100010;

Type    save= record l,r,pos:longint; end;

Var     n,k,ml,mr:longint;
        a:array[0..maxn] of save;
        nheap1,nheap2:longint;
        heap1,heap2:array[0..maxn] of save;
        cou:longint;
        ou:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t,tmp:save;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i].l<t.l do inc(i);
                while t.l<a[j].l do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Push1(x:save);
Var     i,j:longint;
Begin
        inc(nheap1);
        i:=nheap1;
        while i>1 do
        begin
                j:=i shr 1;
                if heap1[j].r<=x.r then break;
                heap1[i]:=heap1[j];
                i:=j;
        end;
        heap1[i]:=x;
End;

Procedure Push2(x:save);
Var     i,j:longint;
Begin
        inc(nheap2);
        i:=nheap2;
        while i>1 do
        begin
                j:=i shr 1;
                if heap2[j].r>=x.r then break;
                heap2[i]:=heap2[j];
                i:=j;
        end;
        heap2[i]:=x;
End;

Function Pop1:save;
Var     i,j:longint;
        x:save;
Begin
        pop1:=heap1[1];
        x:=heap1[nheap1]; dec(nheap1);
        i:=1;
        while i*2<=nheap1 do
        begin
                j:=i*2;
                if (j<nheap1) and (heap1[j+1].r<heap1[j].r) then inc(j);
                if heap1[j].r>=x.r then break;
                heap1[i]:=heap1[j];
                i:=j;
        end;
        heap1[i]:=x;
End;

Function Pop2:save;
Var     i,j:longint;
        x:save;
Begin
        pop2:=heap2[1];
        x:=heap2[nheap2]; dec(nheap2);
        i:=1;
        while i*2<=nheap2 do
        begin
                j:=i*2;
                if (j<nheap2) and (heap2[j+1].r>heap2[j].r) then inc(j);
                if heap2[j].r<=x.r then break;
                heap2[i]:=heap2[j];
                i:=j;
        end;
        heap2[i]:=x;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,k,ml,mr);
        for i:=1 to n do
        with a[i] do
        begin
                readln(l,r);
                pos:=i;
        end;
        sort(1,n);
End;

Procedure Process;
Var     i:longint;
        x,y:save;
Begin
        if ml=mr then
        begin
                cou:=0;
                for i:=1 to n do
                with a[i] do
                        if (l<=ml) and (r>=mr) then
                        begin
                                inc(cou);
                                ou[cou]:=pos;
                        end;
                if cou<k then write(-1) else
                begin
                        writeln(k);
                        for i:=1 to k do write(ou[i],' ');
                end;
                exit;
        end;
        nheap1:=0; nheap2:=0;
        x.l:=0; x.r:=ml;
        for i:=1 to k do push1(x);
        i:=1; cou:=0;
        repeat
                x:=pop1;
                if x.r>=mr then break;
                while (i<=n) and (a[i].l<=x.r) do
                begin
                        push2(a[i]);
                        inc(i);
                end;
                if nheap2>0 then y:=pop2 else y.r:=-1;
                if y.r<=x.r then
                begin
                        write(-1);
                        exit;
                end;
                inc(cou); ou[cou]:=y.pos;
                push1(y);
        until false;
        writeln(cou);
        for i:=1 to cou do write(ou[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.

