Const   ginp='ladder.inp';
        gout='ladder.out';
        maxn=100010;
        oo=trunc(1e15);

type    line= record l,r,vl,vr,y,v:longint; end;

Var     n,high,cou:longint;
        a:array[0..maxn] of line;
        q:array[0..8*maxn] of longint;
        fl,fr:array[0..2*maxn] of int64;

Function Min(x,y:int64):int64;
Begin
        if x<y then min:=x else min:=y;
End;

Function Abs(x:longint):longint;
Begin
        if x<0 then abs:=-x else abs:=x;
End;

Procedure Sortx(l,r:longint; var d,v:array of longint);
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
        sortx(l,j,d,v); sortx(i,r,d,v);
End;

Procedure Sorty(l,r:longint);
Var     i,j,t:longint;
        tmp:line;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l].y;
        repeat
                while a[i].y<t do inc(i);
                while a[j].y>t do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sorty(l,j); sorty(i,r);
End;

Procedure Capn(id,l,r:longint);
Begin
        if (l<r) and (q[id]=0) then exit;
        if l<r then
        begin
                q[id*2]:=q[id];
                q[id*2+1]:=q[id];
                q[id]:=0;
        end;
End;

Procedure Update(id,l,r,dd,cc,v:longint);
Var     mid:longint;
Begin
        capn(id,l,r);
        if (l>cc) or (r<dd) then exit;
        if (dd<=l) and (r<=cc) then
        begin
                q[id]:=v; exit;
        end;
        mid:=(l+r) shr 1;
        update(id*2,l,mid,dd,cc,v);
        update(id*2+1,mid+1,r,dd,cc,v);
End;

Function Quece(id,l,r,v:longint):longint;
Var     mid,q1,q2:longint;
Begin
        capn(id,l,r);
        if (v<l) or (v>r) then exit(0);
        if (v=l) and (r=v) then exit(q[id]);
        mid:=(l+r) shr 1;
        q1:=quece(id*2,l,mid,v);
        q2:=quece(id*2+1,mid+1,r,v);
        if q1>0 then quece:=q1 else quece:=q2;
End;

Procedure Enter;
Var     i:longint;
        d,v:array[0..2*maxn] of longint;
Begin
        readln(n,high);
        for i:=1 to n do
        begin
                readln(a[i].l,a[i].r,a[i].y);
                a[i].v:=i;
                d[i]:=a[i].l; v[i]:=i;
                d[i+n]:=a[i].r; v[i+n]:=i+n;
        end;
        sortx(1,2*n,d,v);
        cou:=0; d[0]:=-1;
        for i:=1 to 2*n do
        begin
                if d[i]>d[i-1] then inc(cou);
                if v[i]<=n then a[v[i]].vl:=cou
                else a[v[i]-n].vr:=cou;
        end;
        sorty(1,n);
End;

Procedure Process;
Var     i,v:longint;
Begin
        for i:=1 to n do
        begin
                v:=quece(1,1,cou,a[i].vl);
                if a[i].y-a[v].y>high then fl[i]:=oo else
                if v=0 then fl[i]:=a[i].y else
                fl[i]:=min(fl[v]+abs(a[i].l-a[v].l),fr[v]+abs(a[i].l-a[v].r))+a[i].y-a[v].y;

                v:=quece(1,1,cou,a[i].vr);
                if a[i].y-a[v].y>high then fr[i]:=oo else
                if v=0 then fr[i]:=a[i].y else
                fr[i]:=min(fl[v]+abs(a[i].r-a[v].l),fr[v]+abs(a[i].r-a[v].r))+a[i].y-a[v].y;

                if a[i].v=1 then break;
                fl[i]:=min(oo,min(fl[i],fr[i]+a[i].r-a[i].l));
                fr[i]:=min(oo,min(fr[i],fl[i]+a[i].r-a[i].l));
                update(1,1,cou,a[i].vl,a[i].vr,i);
        end;
        write(min(fl[i],fr[i]+a[i].r-a[i].l));
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
