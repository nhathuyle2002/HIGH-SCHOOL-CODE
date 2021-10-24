Const   ginp='datphong.inp';
        gout='datphong.out';
        maxn=200010;
        oo=trunc(1e9)+100;

type    save= record w,p:longint; end;

Var     n,m,k,cou:longint;
        res:int64;
        a,b:array[0..maxn] of save;
        leaf:array[0..2*maxn] of longint;
        f:array[0..8*maxn] of longint;

Procedure Sort2(l,r:longint; var d,v:array of longint);
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
                        tmp:=v[i]; v[i]:=v[j]; v[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort2(l,j,d,v); sort2(i,r,d,v);
End;

Procedure Sort1(l,r:longint; var d:array of save);
Var     i,j,t:longint;
        tmp:save;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l].p;
        repeat
                while d[i].p<t do inc(i);
                while d[j].p>t do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort1(l,j,d); sort1(i,r,d);
End;

Procedure Build(id,l,r:longint);
Var     mid:longint;
Begin
        if l=r then
        begin
                leaf[l]:=id; f[id]:=0;
                exit;
        end;
        mid:=(l+r) shr 1;
        build(id*2,l,mid); build(id*2+1,mid+1,r);
End;

Procedure Update(id,x:longint);
Var     id1,id2:longint;
Begin
        id:=leaf[id]; f[id]:=x;
        while id>1 do
        begin
                id:=id shr 1;
                id1:=id*2; id2:=id*2+1;
                if a[f[id1]].p<a[f[id2]].p then f[id]:=f[id1] else f[id]:=f[id2];
        end;
End;

Function Quece(id,l,r,dd,cc:longint):longint;
Var     mid,tmp1,tmp2:longint;
Begin
        if (l>cc) or (r<dd) then exit(0);
        if (dd<=l) and (r<=cc) then exit(f[id]);
        mid:=(l+r) shr 1;
        tmp1:=quece(id*2,l,mid,dd,cc); tmp2:=quece(id*2+1,mid+1,r,dd,cc);
        if a[tmp1].p<a[tmp2].p then quece:=tmp1 else quece:=tmp2;
End;

Procedure Enter;
Var     i:longint;
        d,v:array[0..2*maxn] of longint;
Begin
        readln(n,m,k);
        for i:=1 to n do
        begin
                readln(a[i].p,a[i].w);
                d[i]:=a[i].w; v[i]:=i;
        end;
        for i:=1 to m do
        begin
                readln(b[i].p,b[i].w);
                d[i+n]:=b[i].w; v[i+n]:=i+n;
        end;
        sort2(1,n+m,d,v);
        cou:=0; d[0]:=0;
        for i:=1 to n+m do
        begin
                if d[i]>d[i-1] then inc(cou);
                if v[i]<=n then a[v[i]].w:=cou
                else b[v[i]-n].w:=cou;
        end;
        a[0].p:=oo;
        Build(1,1,cou);
End;

Procedure Process;
Var     i,v:longint;
Begin
        for i:=1 to n do update(a[i].w,i);
        Sort1(1,m,b);
        res:=0;
        for i:=m downto 1 do // sort tang dan //
        begin
                v:=quece(1,1,cou,b[i].w,cou);
                if a[v].p<b[i].p then
                begin
                        res:=res+b[i].p-a[v].p;
                        update(a[v].w,0);
                        dec(k);
                end;
                if k=0 then break;
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
