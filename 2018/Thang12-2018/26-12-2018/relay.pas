Uses    Math;

Const   ginp='relay.inp';
        gout='relay.out';
        maxn=10;//100001;
        oo=trunc(1e9)+100;

Var     n,k,cou:longint;
        res:int64;
        a,b,c:array[0..maxn] of longint;
        d:array[0..2*maxn] of longint;
        f:array[0..8*maxn] of longint;

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
        p:array[0..2*maxn] of longint;
Begin
        readln(n,k);
        for i:=1 to n do
        begin
                readln(a[i],b[i],c[i]);
                d[i]:=a[i]; p[i]:=i;
                d[i+n]:=b[i]; p[i+n]:=i+n;
        end;
        sort(1,2*n,d,p);
        cou:=0; d[0]:=-oo;
        for i:=1 to 2*n do
        begin
                if d[i]>d[cou] then
                begin
                        inc(cou);
                        d[cou]:=d[i];
                end;
                if p[i]<=n then a[p[i]]:=cou
                else b[p[i]-n]:=cou;
        end;
End;

Procedure Build(id,l,r:longint);
Var     mid:longint;
Begin
        f[id]:=oo;
        if l<r then
        begin
                mid:=(l+r) shr 1;
                build(id*2,l,mid);
                build(id*2+1,mid+1,r);
        end;
End;

Procedure Cn(id:longint);
Begin
        f[id*2]:=min(f[id*2],f[id]);
        f[id*2+1]:=min(f[id*2+1],f[id]);
End;

Procedure Update(id,l,r,dd,cc,x:longint);
Var     mid:longint;
Begin
        if l<r then cn(id);
        if (l>cc) or (r<dd) then exit;
        if (dd<=l) and (r<=cc) then
        begin
                f[id]:=min(f[id],x);
                if l<r then cn(id);
                exit;
        end;
        mid:=(l+r) shr 1;
        update(id*2,l,mid,dd,cc,x);
        update(id*2+1,mid+1,r,dd,cc,x);
End;

Function Quece(id,l,r,dd,cc:longint):longint;
var     mid:longint;
Begin
        if l<r then cn(id);
        if (l>cc) or (r<dd) then exit(oo);
        if (dd<=l) and (r<=cc) then exit(f[id]);
        mid:=(l+r) shr 1;
        quece:=min(quece(id*2,l,mid,dd,cc),quece(id*2+1,mid+1,r,dd,cc));
End;

Procedure Process;
Var     i,tmp:longint;
Begin
        build(1,1,cou);
        for i:=1 to n do update(1,1,cou,a[i],b[i],c[i]);
        res:=0;
        for i:=2 to cou do
        begin
                tmp:=quece(1,1,cou,i-1,i);
                res:=res+int64(d[i]-d[i-1])*tmp;
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
