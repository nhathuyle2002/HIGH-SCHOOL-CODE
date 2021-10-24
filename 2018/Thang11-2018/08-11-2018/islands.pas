Uses    Math;

Const   ginp='islands.inp';
        gout='islands.out';
        maxn=1000001;

Type    save= record h,pos:longint; end;

Var     m,n,nn,res,cou:longint;
        a:array[0..maxn] of save;
        root,hh:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t,tmp:save;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i].h<t.h do inc(i);
                while t.h<a[j].h do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i,j,x:longint;
Begin
        readln(m,n);
        nn:=0;
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(x);
                        inc(nn);
                        a[nn].pos:=(i-1)*n+j; a[nn].h:=x;
                end;
                readln;
        end;
        sort(1,nn);
End;

Function Find(p:longint):longint; inline;
Begin
        if root[p]=0 then exit(0);
        while root[p]<>p do p:=root[p];
        find:=p;
End;

Procedure Add(x,y:longint); inline;
Var     x0,y0:longint;
Begin
        y0:=find(y);
        if y0=0 then exit;
        x0:=find(x);
        if hh[y0]<hh[x0] then
        begin
                root[x]:=x0; root[y]:=x0; root[y0]:=x0;
                hh[x0]:=max(hh[x0],hh[y0]+1);
        end else
        begin
                root[y]:=y0; root[x]:=y0; root[x0]:=y0;
                hh[y0]:=max(hh[y0],hh[x0]+1);
        end;
        if x0<>y0 then dec(cou);
End;

Procedure Process;
Var     i,high,pi,pj:longint;
Begin
        for i:=1 to nn do root[i]:=0;
        res:=0; cou:=0;
        i:=nn;
        for high:=maxn downto 1 do
        begin
                while (i>0) and (a[i].h=high) do
                with a[i] do
                begin
                        inc(cou);
                        root[pos]:=pos; hh[pos]:=1;
                        pi:=(pos-1) div n+1; pj:=(pos-1) mod n+1;
                        if pi>1 then add(pos,pos-n);
                        if pi<m then add(pos,pos+n);
                        if pj>1 then add(pos,pos-1);
                        if pj<n then add(pos,pos+1);
                        dec(i);
                end;
                if res<cou then res:=cou;
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
