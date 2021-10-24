Uses    Math;

Const   ginp='machine3.inp';
        gout='machine3.out';
        maxn=1000001;

Var     n,k,res,maxx:longint;
        a,b:array[0..maxn] of longint;
        f:array[0..4,-1..maxn*3] of longint;

Procedure Sort(l,r:longint);
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
                        tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,k);
        maxx:=0;
        for i:=1 to n do
        begin
                readln(a[i],b[i]);
                maxx:=max(maxx,b[i]);
        end;
        sort(1,n);
End;

Procedure Process;
Var     i,x,j:longint;
Begin
        i:=1;
        for x:=0 to maxx do
        begin
                for j:=0 to k-1 do
                        f[j,x]:=max(f[j,x-1],f[j,x]);
                while (i<=n) and (a[i]=x+1) do
                begin
                        for j:=0 to k-1 do
                                if (j=0) or (f[j,x]<>0) then
                                f[j+1,b[i]]:=max(f[j+1,b[i]],f[j,x]+b[i]-a[i]);
                        inc(i);
                end;
        end;
        res:=0;
        for x:=1 to maxx do res:=max(res,f[k,x]);
        if res=0 then write(-1) else write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
