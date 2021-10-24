Const   ginp='rail.inp';
        gout='rail.out';
        maxn=300010;

Var     n,cou:longint;
        a:array[0..maxn] of int64;
        o:array[0..maxn] of longint;
        l,r:longint;
        q:array[0..maxn] of longint;

Procedure Push(i:longint);
Begin
        while (l<=r) and (a[i]<=a[q[r]]) do dec(r);
        inc(r); q[r]:=i;
End;

Procedure Pop(i:longint);
Begin
        while (l<=r) and (q[l]<=i) do inc(l);
End;

Function Check(k:longint):boolean;
Var     i,ii:longint;
Begin
        l:=1; r:=0;
        for i:=1 to k-1 do
                if a[i]>0 then push(i);
        ii:=0;
        for i:=0 to n-k-1 do
        begin
                if a[i+k]>a[ii] then push(i+k);
                if i=ii then
                begin
                        if l>r then exit(false);
                        ii:=q[l]; pop(ii);
                end;
        end;
        if a[n]<=a[ii] then exit(false) else exit(true);
End;

Procedure Answ(k:longint);
Var     i,ii:longint;
Begin
        cou:=0;
        l:=1; r:=0;
        for i:=1 to k-1 do
                if a[i]>0 then push(i);
        ii:=0;
        for i:=0 to n-k-1 do
        begin
                if a[i+k]>a[ii] then push(i+k);
                if i=ii then
                begin
                        //if l>r then exit(false);
                        ii:=q[l]; pop(ii);
                        inc(cou); o[cou]:=ii;
                end;
        end;
        //if a[n]<=a[ii] then exit(false) else exit(true);
        inc(cou); o[cou]:=n;
        writeln(cou,' ',k);
        for i:=1 to cou do write(o[i]-o[i-1],' ');
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        a[0]:=0;
        for i:=1 to n do
        begin
                read(a[i]);
                a[i]:=a[i]+a[i-1];
        end;
End;

Procedure Process;
Var     lt,rt,mid:longint;
Begin
        lt:=1; rt:=n+1;
        while lt<rt do
        begin
                mid:=(lt+rt) shr 1;
                if check(mid) then rt:=mid else lt:=mid+1;
        end;
        answ(lt);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
