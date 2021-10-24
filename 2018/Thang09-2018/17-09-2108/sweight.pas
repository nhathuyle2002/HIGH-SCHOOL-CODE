Const   ginp='sweight.inp';
        gout='sweight.out';
        maxn=200010;

Var     n,cou,res:longint;
        a,b,f:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
        for i:=n downto 1 do
                if a[i]<a[i+1] then b[i]:=b[i+1]+1 else b[i]:=1;
End;

Procedure Compress;
Var     i,j:longint;
        c,v:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
Var     t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=c[random(r-l+1)+l];
        repeat
                while c[i]<t do inc(i);
                while c[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=c[i]; c[i]:=c[j]; c[j]:=tmp;
                        tmp:=v[i]; v[i]:=v[j]; v[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Begin
        for i:=1 to n do
        begin
                c[i]:=a[i]; v[i]:=i;
        end;
        sort(1,n);
        cou:=0; c[0]:=0;
        for i:=1 to n do
        begin
                if c[i]>c[i-1] then inc(cou);
                a[v[i]]:=cou;
        end;
End;

Function Max(x,y:longint):longint;
Begin
        if x>y then max:=x else max:=y;
End;

Function Quece(i:longint):longint;
Begin
        if i<1 then exit(0);
        quece:=max(f[i],quece(i-i and (-i)));
End;

Procedure Update(i,x:longint);
Begin
        if i>cou then exit;
        f[i]:=max(f[i],x);
        update(i+i and (-i),x);
End;

Procedure Process;
Var     i,tmp,count:longint;
Begin
        res:=0; count:=0;
        for i:=1 to n do
        begin
                if a[i]>a[i-1] then inc(count) else count:=1;
                res:=max(res,quece(a[i]-1)+b[i]);
                update(a[i],count);
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Compress;
        Process;
        Close(input); Close(output);
End.
