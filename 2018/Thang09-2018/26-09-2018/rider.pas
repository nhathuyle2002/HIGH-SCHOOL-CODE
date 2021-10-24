Const   ginp='rider.inp';
        gout='rider.out';
        maxn=100010;

Var     m,n:longint;
        a,b,va,vb:array[0..maxn] of longint;
        res:array[0..maxn] of real;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i]<t do inc(i);
                while b[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
                        tmp:=vb[i]; vb[i]:=vb[j]; vb[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
end;

Procedure Enter;
Var     i,mm:longint;
Begin
        readln(m);
        for i:=1 to m do read(a[i]);
        mm:=m; m:=0;
        for i:=1 to mm do
                if a[i]>a[m] then
                begin
                        while (m>0) and ((a[i]-a[m-1])/(i-va[m-1])>=(a[m]-a[m-1])/(va[m]-va[m-1])) do dec(m);
                        inc(m); a[m]:=a[i]; va[m]:=i;
                end;
        readln; readln(n);
        for i:=1 to n do
        begin
                read(b[i]);
                vb[i]:=i;
        end;
        sort(1,n);
End;

Procedure Process;
Var     i,j:longint;
Begin
        j:=1;
        for i:=1 to n do
        begin
                while a[j]<=b[i] do inc(j);
                while (j<m) and ((a[j]-b[i])/va[j]<=(a[j+1]-b[i])/va[j+1]) do inc(j);
                res[vb[i]]:=va[j]/(a[j]-b[i]);
        end;
        for i:=1 to n do writeln(res[i]:0:6);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
