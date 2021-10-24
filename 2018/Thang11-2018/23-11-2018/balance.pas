Const   ginp='balance.inp';
        gout='balance.out';
        maxn=21;
        maxb=60001;

Var     n,m:longint;
        res:int64;
        a:array[0..maxn] of longint;
        d,c:array[1..2,0..maxb] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to n do read(a[i]);
End;

Procedure Sort(l,r:longint; var a:array of longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]<t do inc(i);
                while a[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,a); sort(i,r,a);
End;


Procedure Try(i,nn,sum,typ:longint);
Begin
        if i=nn+1 then
        begin
                inc(d[typ,0]);
                d[typ,d[typ,0]]:=sum;
                exit;
        end;
        try(i+1,nn,sum,typ);
        try(i+1,nn,sum-a[i],typ);
        try(i+1,nn,sum+a[i],typ);
End;

Procedure Chuanhoa(typ:longint);
Var     nn,i:longint;
Begin
        nn:=d[typ,0];
        d[typ,0]:=1; c[typ,1]:=1;
        for i:=2 to nn do
                if d[typ,i]=d[typ,i-1] then inc(c[typ,d[typ,0]]) else
                begin
                        inc(d[typ,0]);
                        d[typ,d[typ,0]]:=d[typ,i];
                        c[typ,d[typ,0]]:=1;
                end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        d[1,0]:=0; try(1,n shr 1,0,1);
        d[2,0]:=0; try(n shr 1+1,n,0,2);
        sort(1,d[1,0],d[1]); chuanhoa(1);
        sort(1,d[2,0],d[2]); chuanhoa(2);
        res:=0;
        d[1,d[1,0]+1]:=trunc(1e9);
        d[2,d[2,0]+1]:=trunc(1e9);
        j:=1;
        for i:=1 to d[1,0] do
        begin
                while d[1,i]+m>d[2,j] do inc(j);
                if d[1,i]+m=d[2,j] then res:=res+int64(c[1,i])*c[2,j];
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
