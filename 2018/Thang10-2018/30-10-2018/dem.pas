Const   ginp='dem.inp';
        gout='dem.out';
        maxn=500010;
        sn=709;

Type    TVan= record l,r,pos:longint; end;

Var     n,nq,cou:longint;
        a,d,v,res:array[0..maxn] of longint;
        q:array[0..maxn] of TVan;

Function Cmp(a,b:TVan):boolean;
Begin
        if a.l div sn<>b.l div sn then exit(a.l<b.l);
        if a.r<>b.r then exit(a.r<b.r);
        exit(a.l<b.l);
End;

Procedure Sortq(l,r:longint);
Var     i,j:longint;
        t,tmp:TVan;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=q[random(r-l+1)+l];
        repeat
                while cmp(q[i],t) do inc(i);
                while cmp(t,q[j]) do dec(j);
                if i<=j then
                begin
                        tmp:=q[i]; q[i]:=q[j]; q[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sortq(l,j); sortq(i,r);
End;

Procedure Sorta(l,r:longint);
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
        sorta(l,j); sorta(i,r);
End;

Procedure Pop(i:longint);
Begin
        if d[a[i]]=2 then dec(cou) else
        if d[a[i]]=3 then inc(cou);
        dec(d[a[i]]);
End;

Procedure Push(i:longint);
Begin
        if d[a[i]]=1 then inc(cou) else
        if d[a[i]]=2 then dec(cou);
        inc(d[a[i]]);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,nq);
        for i:=1 to n do
        begin
                read(a[i]);
                d[i]:=a[i]; v[i]:=i;
        end;
        sorta(1,n);
        d[0]:=-1; cou:=0;
        for i:=1 to n do
        begin
                if d[i]>d[i-1] then inc(cou);
                a[v[i]]:=cou;
        end;
        readln;
        for i:=1 to nq do
        begin
                readln(q[i].l,q[i].r);
                q[i].pos:=i;
        end;
        sortq(1,nq);
End;

Procedure Process;
Var     i,vl,vr:longint;
Begin
        fillchar(d,sizeof(d),0); cou:=0;
        vl:=1; vr:=0;
        for i:=1 to nq do
        with q[i] do
        begin
                while (vl<l) do
                begin
                        pop(vl); inc(vl);
                end;
                while (vl>l) do
                begin
                        dec(vl); push(vl);
                end;
                while (vr<r) do
                begin
                        inc(vr); push(vr);
                end;
                while (vr>r) do
                begin
                        pop(vr); dec(vr);
                end;
                res[pos]:=cou;
        end;
        for i:=1 to nq do writeln(res[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
