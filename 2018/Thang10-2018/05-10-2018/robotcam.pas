Const   ginp='robotcam.inp';
        gout='robotcam.out';
        maxn=100010;

Type    point= record x,y:longint; end;

Var     n,res,cou:longint;
        a:array[0..maxn] of point;
        leaf,d:array[0..maxn] of longint;
        f:array[0..4*maxn] of boolean;

Procedure Sortd(l,r:longint; var d,v:array of longint);
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
        sortd(l,j,d,v); sortd(i,r,d,v);
End;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t,tmp:point;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].x<t.x) or ((a[i].x=t.x) and (a[i].y<t.y)) do inc(i);
                while (a[j].x>t.x) or ((a[j].x=t.x) and (a[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
        d,v:array[0..maxn] of longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                readln(a[i].x,a[i].y);
                d[i]:=a[i].y; v[i]:=i;
        end;
        sortd(1,n,d,v);
        cou:=0; d[0]:=-maxlongint;
        for i:=1 to n do
        begin
                if d[i]>d[i-1] then inc(cou);
                a[v[i]].y:=cou;
        end;
        sort(1,n);
End;

Procedure Build(id,l,r:longint);
Var     mid:longint;
Begin
        if l=r then
        begin
                leaf[l]:=id;
                f[id]:=false;
        end else
        begin
                mid:=(l+r) shr 1;
                build(id*2,l,mid);
                build(id*2+1,mid+1,r);
                f[id]:=false;
        end;
End;

Function Quece(id,l,r,v:longint):longint;
Var     mid:longint;
Begin
        if (l>v) or (not f[id]) then exit(0);
        if l=r then exit(l);
        mid:=(l+r) shr 1;
        quece:=quece(id*2+1,mid+1,r,v);
        if quece=0 then quece:=quece(id*2,l,mid,v)
End;

Procedure Update(i,typ:longint);
Var     id:longint;
Begin
        d[i]:=d[i]+typ;
        id:=leaf[i];
        if d[i]=0 then f[id]:=false else f[id]:=true;
        while id>1 do
        begin
                id:=id shr 1;
                f[id]:=f[id*2] or f[id*2+1];
        end;
End;

Procedure Process;
Var     i,v:longint;
Begin
        build(1,1,cou);
        res:=0;
        for i:=1 to n do
        begin
                v:=quece(1,1,cou,a[i].y);
                if v=0 then inc(res)
                else update(v,-1);
                update(a[i].y,1);
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
