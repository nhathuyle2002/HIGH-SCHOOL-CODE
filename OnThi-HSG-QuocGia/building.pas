Const   ginp='building.inp';
        gout='building.out';
        maxn=500001;

Var     n,res1,res2:longint;
        a,typ:array[0..maxn] of longint;

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
                        tmp:=typ[i]; typ[i]:=typ[j]; typ[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i]);
                if a[i]<0 then
                begin
                        a[i]:=-a[i];
                        typ[i]:=1;
                end;
        end;
        sort(1,n);
End;

Procedure Process;
Var     i,di:longint;
Begin
        res1:=0;
        di:=0; a[0]:=0; typ[0]:=0;
        for i:=1 to n do
                if (typ[i]<>typ[di]) and (a[i]>a[di]) then
                begin
                        inc(res1);
                        di:=i;
                end;
        res2:=0;
        di:=0; a[0]:=0; typ[0]:=1;
        for i:=1 to n do
                if (typ[i]<>typ[di]) and (a[i]>a[di]) then
                begin
                        inc(res2);
                        di:=i;
                end;
        if res1>res2 then write(res1) else write(res2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
