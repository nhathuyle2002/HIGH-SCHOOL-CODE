Uses    Math;

Const   ginp='palmatrix.inp';
        gout='palmatrix.out';
        maxn=100001;

Var     m,n,k,res:longint;
        a:array[0..maxn] of ansistring;
        f,f2:array[0..maxn] of longint;

Function Check(s:string):longint;
Var     i,j,cou:longint;
Begin
        check:=0;
        for i:=1 to 4 do
        begin
                cou:=1;
                for j:=i+1 to 4 do
                        if s[i]=s[j] then inc(cou);
                check:=max(check,cou);
        end;
        check:=4-check;
End;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=random(r-l+1)+l;
        t:=f2[t]-f[t];
        repeat
                while f2[i]-f[i]<t do inc(i);
                while f2[j]-f[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=f[i]; f[i]:=f[j]; f[j]:=tmp;
                        tmp:=f2[i]; f2[i]:=f2[j]; f2[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n,k);
        for i:=1 to m do readln(a[i]);
        for i:=1 to m do
                for j:=1 to (n+1) div 2 do
                        if a[i,j]<>a[i,n-j+1] then inc(f[j]);
        for i:=1 to (m+1) div 2 do
                for j:=1 to (n+1) div 2 do
                        if (2*i=m+1) and (a[i,j]<>a[i,n-j+1]) then inc(f2[j]) else
                        if (2*j=n+1) and (a[i,j]<>a[m-i+1,j]) then inc(f2[j]) else
                        if (2*i<>m+1) and (2*j<>n+1) then f2[j]:=f2[j]+check(a[i,j]+a[i,n-j+1]+a[m-i+1,j]+a[m-i+1,n-j+1]);
End;

Procedure Process;
Var     i:longint;
Begin
        if (n mod 2=1) and (k mod 2=1) then
        begin
                res:=0;
                n:=(n+1) div 2;
                k:=(k+1) div 2;
        end else
        if n mod 2=1 then
        begin
                res:=f[(n+1) div 2];
                n:=n div 2;
                k:=k div 2;
        end else
        if k mod 2=1 then
        begin
                res:=0;
                n:=n div 2;
                k:=(k+1) div 2;
        end else
        begin
                res:=0;
                n:=n div 2;
                k:=k div 2;
        end;
        sort(1,n);
        for i:=1 to k do res:=res+f2[i];
        for i:=k+1 to n do res:=res+f[i];
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
