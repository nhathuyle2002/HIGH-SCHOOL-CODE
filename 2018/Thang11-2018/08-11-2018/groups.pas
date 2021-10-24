Const   ginp='groups.inp';
        gout='groups.out';
        maxn=100010;

Var     n,k,res:longint;
        x,y:array[0..maxn] of longint;
        d,pos:array[0..2*maxn] of longint;

Procedure Sort1(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=x[random(r-l+1)+l];
        repeat
                while x[i]<t do inc(i);
                while t<x[j] do dec(j);
                if i<=j then
                begin
                        tmp:=x[i]; x[i]:=x[j]; x[j]:=tmp;
                        tmp:=y[i]; y[i]:=y[j]; y[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort1(l,j); sort1(i,r);
End;

Procedure Sort2(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while t<d[j] do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        tmp:=pos[i]; pos[i]:=pos[j]; pos[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort2(l,j); sort2(i,r);
End;

Procedure Enter;
Var     i,t:longint;
Begin
        readln(n,k);
        for i:=1 to k do
        begin
                readln(x[i],y[i]);
                if x[i]>y[i] then
                begin
                        t:=x[i]; x[i]:=y[i]; y[i]:=t;
                end;
                d[i]:=x[i]; pos[i]:=i;
                d[i+k]:=y[i]; pos[i+k]:=i+k;
        end;
        sort2(1,2*k);
        n:=0;
        for i:=1 to 2*k do
        begin
                if d[i]<>d[i-1] then inc(n);
                if pos[i]<=k then x[pos[i]]:=n else y[pos[i]-k]:=n;
        end;
        sort1(1,k);
End;

Procedure Process;
Var     i,ii,minp:longint;
Begin
        res:=0; ii:=1; minp:=0;
        for i:=1 to n do
        begin
                if i>=minp then
                begin
                        inc(res);
                        minp:=n+1;
                end;
                while (ii<=k) and (x[ii]=i) do
                begin
                        if y[ii]<minp then minp:=y[ii];
                        inc(ii);
                end;
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
