Const   ginp='subseq.inp';
        gout='subseq.out';
        maxn=100010;

Var     n,delta,nit,ir,cou:longint;
        x,a,b,c,trace,f,o:array[0..maxn] of longint;
        leaf:array[0..3*maxn] of longint;
        it:array[0..12*maxn] of longint;

Procedure Sort(l,r:longint; var d,p:array of longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        tmp:=p[i]; p[i]:=p[j]; p[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d,p); sort(i,r,d,p);
End;

Procedure Enter;
Var     i:longint;
        d,p:array[0..3*maxn] of longint;
Begin
        readln(n,delta);
        for i:=1 to n do
        begin
                read(x[i]);
                d[i]:=x[i]; p[i]:=i;
                d[i+n]:=x[i]-delta; p[i+n]:=i+n;
                d[i+2*n]:=x[i]+delta; p[i+2*n]:=i+2*n;
        end;
        sort(1,3*n,d,p);
        nit:=0;
        d[0]:=-trunc(2e9)-100;
        for i:=1 to 3*n do
        begin
                if d[i]>d[i-1] then inc(nit);
                if p[i]<=n then a[p[i]]:=nit else
                if p[i]<=2*n then b[p[i]-n]:=nit else
                c[p[i]-2*n]:=nit;
        end;
End;

Procedure Build(id,l,r:longint);
Var     mid:longint;
Begin
        it[id]:=0;
        if l=r then leaf[l]:=id else
        begin
                mid:=(l+r) shr 1;
                build(id*2,l,mid);
                build(id*2+1,mid+1,r);
        end;
End;

Procedure Update(id,i:longint);
Begin
        id:=leaf[id];
        while id>0 do
        begin
                if f[i]<=f[it[id]] then break else it[id]:=i;
                id:=id shr 1;
        end;
End;

Function Query(id,l,r,dd,cc:longint):longint;
Var     mid,q1,q2:longint;
Begin
        if (l>cc) or (r<dd) then exit(0);
        if (dd<=l) and (r<=cc) then exit(it[id]);
        mid:=(l+r) shr 1;
        q1:=query(id*2,l,mid,dd,cc);
        q2:=query(id*2+1,mid+1,r,dd,cc);
        if f[q1]>f[q2] then exit(q1) else exit(q2);
End;

Procedure Process;
Var     i:longint;
Begin
        build(1,1,nit);
        f[0]:=0; ir:=0;
        for i:=1 to n do
        begin
                trace[i]:=query(1,1,nit,b[i],c[i]);
                f[i]:=f[trace[i]]+1;
                update(a[i],i);
                if f[i]>f[ir] then ir:=i;
        end;
        cou:=0;
        while ir<>0 do
        begin
                inc(cou); o[cou]:=x[ir];
                ir:=trace[ir];
        end;
        writeln(cou);
        for i:=cou downto 1 do write(o[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
