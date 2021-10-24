Const   ginp='xedap.inp';
        gout='xedap.out';
        maxn=100010;

Type    save= record d,t:longint; end;

Var     n,q,sumt:longint;
        sumr:int64;
        res:array[0..maxn] of int64;
        a:array[0..maxn] of save;
        b,pos:array[0..maxn] of longint;

Procedure Sorta(l,r:longint);
Var     i,j:longint;
        t,tmp:save;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i].d<t.d do inc(i);
                while a[j].d>t.d do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sorta(l,j); sorta(i,r);
End;

Procedure Sortb(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i]<t do inc(i);
                while b[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
                        tmp:=pos[i]; pos[i]:=pos[j]; pos[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sortb(l,j); sortb(i,r);
End;

Procedure Enter;
Var     i,nn,t,d:longint;
        s:string[1];
Begin
        readln(nn,q);
        n:=0;
        for i:=1 to nn do
        begin
                readln(s,t,d);
                if t>a[n].t then
                begin
                        inc(n);
                        a[n].t:=t; a[n].d:=a[n-1].d;
                        a[n-1].t:=t-a[n-1].t;
                end;
                if s='+' then inc(a[n].d,d) else dec(a[n].d,d);
        end;
        sorta(1,n-1);
        for i:=1 to q do
        begin
                read(b[i]);
                pos[i]:=i;
        end;
        sortb(1,q);
End;

Procedure Process;
Var     i,j,nn:longint;
Begin
        sumt:=0; sumr:=0;
        nn:=0;
        for i:=1 to n-1 do
                if a[i].d>=0 then break else
                begin
                        sumt:=sumt+a[i].t;
                        sumr:=sumr+int64(-a[i].d)*a[i].t;
                        nn:=i;
                end;
        i:=nn;
        b[0]:=0;
        for j:=1 to q do
        begin
                while (i>0) and (b[j]+a[i].d>=0) do
                begin
                        sumt:=sumt-a[i].t;
                        sumr:=sumr-int64(-a[i].d-b[j-1])*a[i].t;
                        dec(i);
                end;
                sumr:=sumr-int64(b[j]-b[j-1])*sumt;
                if b[j]+a[n].d<0 then res[pos[j]]:=-1 else res[pos[j]]:=sumr;
        end;
        for j:=1 to q do
                if res[j]=-1 then writeln('INFINITY') else writeln(res[j]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
