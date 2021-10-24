Uses    Math;

Const   ginp='cone.inp';
        gout='cone.out';
        maxn=100010;

Var     n,nn:longint;
        res:int64;
        a,p,leaf:array[0..maxn] of longint;
        dl,dr:array[0..maxn] of int64;
        f:array[0..4*maxn] of int64;

Procedure Build(id,l,r:longint);
Var     mid:longint;
Begin
        f[id]:=0;
        if l=r then leaf[l]:=id else
        begin
                mid:=(l+r) shr 1;
                build(id*2,l,mid);
                build(id*2+1,mid+1,r);
        end;
End;

Function Calc(x:longint):longint;
Begin
        calc:=0;
        while x>0 do
        begin
                calc:=calc+x mod 10;
                x:=x div 10;
        end;
End;

Procedure Update(id:longint; x:int64);
Begin
        id:=leaf[id]; f[id]:=x;
        id:=id shr 1;
        while id>0 do
        begin
                f[id]:=max(f[id*2],f[id*2+1]);
                id:=id shr 1;
        end;
End;

Function Quece(id,l,r,dd,cc:longint):int64;
Var     mid:longint;
Begin
        if (l>r) or (l>cc) or (r<dd) then exit(0);
        if (dd<=l) and (r<=cc) then exit(f[id]);
        mid:=(l+r) shr 1;
        quece:=max(quece(id*2,l,mid,dd,cc),quece(id*2+1,mid+1,r,dd,cc));
End;

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
        d,pp:array[0..maxn] of longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(d[i]);
                a[i]:=calc(d[i]); pp[i]:=i;
        end;
        sort(1,n,d,pp);
        d[0]:=0;
        nn:=0;
        for i:=1 to n do
        begin
                if d[i]>d[i-1] then inc(nn);
                p[pp[i]]:=nn;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        build(1,1,nn);
        for i:=1 to n do
        begin
                dl[i]:=quece(1,1,nn,1,p[i]-1)+a[i];
                update(p[i],dl[i]);
        end;
        build(1,1,nn);
        for i:=n downto 1 do
        begin
                dr[i]:=quece(1,1,nn,1,p[i]-1)+a[i];
                update(p[i],dr[i]);
        end;
        res:=0;
        for i:=1 to n do
                res:=max(res,dl[i]+dr[i]-a[i]);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
