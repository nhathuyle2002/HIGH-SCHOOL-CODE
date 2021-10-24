Uses    Math;

Const   ginp='fillnum.inp';
        gout='fillnum.out';
        maxq=100010;

Type    save= record p1,p2:longint; end;

Var     n,q:longint;
        a,b:array[0..maxq] of save;
        res,mu10,modul:int64;
        c,leaf:array[0..maxq] of longint;
        it:array[0..4*maxq] of longint;

Procedure Sort(l,r:longint; var c:array of save);
Var     i,j:longint;
        t,tmp:save;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=c[random(r-l+1)+l];
        repeat
                while c[i].p1<t.p1 do inc(i);
                while t.p1<c[j].p1 do dec(j);
                if i<=j then
                begin
                        tmp:=c[i]; c[i]:=c[j]; c[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,c); sort(i,r,c);
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

Procedure Update(id,x:longint);
Begin
        id:=leaf[id];
        it[id]:=x;
        id:=id shr 1;
        while id>0 do
        begin
                it[id]:=max(it[id*2],it[id*2+1]);
                id:=id shr 1;
        end;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,q,modul);
        c[0]:=0;
        for i:=1 to q do
        begin
                readln(a[i].p1,b[i].p1,c[i]);
                a[i].p2:=i; b[i].p2:=i;
        end;
        sort(1,q,a); sort(1,q,b);
End;

Procedure Process;
Var     p,i,j:longint;
Begin
        build(1,1,q);
        res:=0; mu10:=1;
        i:=q; j:=q;
        for p:=n downto 1 do
        begin
                while (i>0) and (b[i].p1>=p) do
                begin
                        update(b[i].p2,b[i].p2);
                        dec(i);
                end;
                while (j>0) and (a[j].p1>p) do
                begin
                        update(a[j].p2,0);
                        dec(j);
                end;
                res:=(res+c[it[1]]*mu10) mod modul;
                mu10:=(mu10*10) mod modul;
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
