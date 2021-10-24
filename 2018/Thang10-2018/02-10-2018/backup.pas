Const   ginp='backup.inp';
        gout='backup.out';
        maxn=100010;
        //oo=trunc(1e9)+100;

Type    save= record l,r:longint; w:int64; end;

Var     n,k,nheap:longint;
        res:int64;
        a,vl,vr:array[0..maxn] of longint;
        sum:array[0..maxn] of int64;
        d:array[0..maxn] of boolean;
        //f:array[0..maxn,0..maxn shr 1] of int64;
        heap:array[0..maxn*4] of save;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

{Function Min(x,y:longint):longint;
Begin
        If x<y then min:=x else min:=y;
End;}

{Procedure Process;
Var     i,j:longint;
Begin
        for j:=1 to k do
        begin
                f[0,j]:=oo; f[1,j]:=oo;
        end;
        for i:=2 to n do
                for j:=1 to k do
                        f[i,j]:=min(f[i-1,j],f[i-2,j-1]+a[i]-a[i-1]);
        writeln(f[n,k]);
End;}

Procedure Swap(var x,y:save);
Var     tmp:save;
Begin
        tmp:=x; x:=y; y:=tmp;
End;

Procedure Push(i,j:longint);
Begin
        if (i<1) or (j>n) then exit;
        inc(nheap);
        with heap[nheap] do
        begin
                l:=i; r:=j;
                w:=sum[j]+sum[i];
        end;
        i:=nheap;
        while i>1 do
        begin
                j:=i shr 1;
                if heap[i].w>=heap[j].w then break else
                begin
                        swap(heap[i],heap[j]);
                        i:=j;
                end;
        end;
End;

Function Pop:save;
Var     i,j:longint;
Begin
        pop:=heap[1];
        swap(heap[1],heap[nheap]); dec(nheap);
        i:=1;
        while i shl 1<=nheap do
        begin
                j:=i shl 1;
                if (j<nheap) and (heap[j+1].w<heap[j].w) then inc(j);
                if heap[j].w>=heap[i].w then break else
                begin
                        swap(heap[i],heap[j]);
                        i:=j;
                end;
        end;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,k);
        for i:=1 to n do read(a[i]);
        sort(1,n);
        for i:=2 to n do
                sum[i]:=-sum[i-1]+a[i]-a[i-1];
End;

Procedure Process2;
Var     i,kk,ll,rr:longint;
        p:save;
Begin
        res:=0; nheap:=0;
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
        begin
                vl[i]:=i-1; vr[i]:=i+1;
                push(i,i+1);
        end;
        kk:=0;
        repeat
                p:=pop;
                with p do
                if d[l] and d[r] then
                begin
                        inc(kk); res:=res+w;
                        d[l]:=false; d[r]:=false;
                        ll:=l; rr:=r;
                        while not d[ll] do ll:=vl[ll];
                        while not d[rr] do rr:=vr[rr];
                        push(ll,rr);
                        while l<>ll do
                        begin   i:=vl[l]; vl[l]:=ll; l:=i; end;
                        while r<>rr do
                        begin   i:=vr[r]; vr[r]:=rr; r:=i; end;
                end;
        until kk=k;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        //Process;
        Process2;
        Close(input); Close(output);
End.
