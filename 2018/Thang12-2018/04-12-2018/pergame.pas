Const   ginp='pergame.inp';
        gout='pergame.out';
        maxn=201;

Var     n,r1,r2:longint;
        a,b:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do read(a[i]);
End;

Procedure Swap(Var x,y:longint);
Var     tmp:longint;
Begin
        tmp:=x; x:=y; y:=tmp;
End;

Function Search(x:longint):longint;
Var     i:longint;
Begin
        for i:=1 to n do
                if b[i]=x then exit(i);
End;

Procedure Process;
Var     i,p1,p2:longint;
Begin
        r1:=0; b:=a;
        p1:=search(n div 2);
        if p1<>1 then
        begin
                inc(r1);
                swap(b[1],b[p1]);
        end;
        p2:=search(n div 2+1);
        if p2<>n then
        begin
                inc(r1);
                swap(b[n],b[p2]);
        end;
        for i:=2 to n-1 do
                if (i mod 2=1) and (b[i]>n div 2) then inc(r1);
        r2:=0; b:=a;
        p1:=search(n div 2+1);
        if p1<>1 then
        begin
                inc(r2);
                swap(b[1],b[p1]);
        end;
        p2:=search(n div 2);
        if p2<>n then
        begin
                inc(r2);
                swap(b[n],b[p2]);
        end;
        for i:=2 to n-1 do
                if (i mod 2=0) and (b[i]>n div 2) then inc(r2);
        if r1<r2 then write(r1) else write(r2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
