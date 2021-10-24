Const   ginp='orderset.inp';
        gout='orderset.out';
        maxn=300010;

Var     n,nit:longint;
        ms:array[0..maxn] of string[1];
        a,b,d,leaf:array[0..maxn] of longint;
        it:array[0..4*maxn] of longint;

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
Var     i,cou:longint;
        d,p:array[0..maxn] of longint;
Begin
        readln(n);
        cou:=0;
        for i:=1 to n do
        begin
                readln(ms[i],a[i]);
                b[i]:=a[i];
                if ms[i]<>'K' then
                begin
                        inc(cou);
                        d[cou]:=a[i]; p[cou]:=i;
                end;
        end;
        sort(1,cou,d,p);
        nit:=0;
        d[0]:=-trunc(1e9)-100;
        for i:=1 to cou do
        begin
                if d[i]>d[i-1] then
                begin
                        inc(nit);
                        b[nit]:=d[i];
                end;
                a[p[i]]:=nit;
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

Procedure Update(i,x:longint);
Begin
        if (d[i]+x<0) or (d[i]+x>1) then exit;
        d[i]:=d[i]+x;
        i:=leaf[i];
        while i>0 do
        begin
                it[i]:=it[i]+x;
                i:=i shr 1;
        end;
End;

Function Query(id,l,r,dd,cc:longint):longint;
Var     mid,q1,q2:longint;
Begin
        if (l>r) or (l>cc) or (r<dd) then exit(0);
        if (dd<=l) and (r<=cc) then exit(it[id]);
        mid:=(l+r) shr 1;
        query:=query(id*2,l,mid,dd,cc)+query(id*2+1,mid+1,r,dd,cc);
End;

Procedure Process;
Var     i,l,r,mid:longint;
Begin
        build(1,1,nit);
        for i:=1 to nit do d[i]:=0;
        for i:=1 to n do
                if ms[i]='I' then Update(a[i],1) else
                if ms[i]='D' then Update(a[i],-1) else
                if ms[i]='C' then writeln(query(1,1,nit,1,a[i]-1)) else
                begin
                        l:=1; r:=nit+1;
                        while l<r do
                        begin
                                mid:=(l+r) shr 1;
                                if query(1,1,nit,1,mid)>=a[i] then r:=mid else l:=mid+1;
                        end;
                        if r=nit+1 then writeln('invalid') else writeln(b[r]);
                end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
