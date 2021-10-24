Uses    Math;

Const   ginp='machine.inp';
        gout='machine.out';
        maxn=1000001;
        k=2;

Var     n,res,maxx:longint;
        a,b:array[0..maxn] of longint;
        f:array[0..3,-1..maxn*3] of longint;

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
        readln(n);
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
        for j:=0 to k-1 do
        begin
                i:=1;
                for x:=0 to maxx do
                begin
                        f[j,x]:=max(f[j,x-1],f[j,x]);
                        while (i<=n) and (a[i]=x+1) do
                        begin
                                f[j+1,b[i]]:=max(f[j+1,b[i]],f[j,x]+b[i]-a[i]);
                                inc(i);
                        end;
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
