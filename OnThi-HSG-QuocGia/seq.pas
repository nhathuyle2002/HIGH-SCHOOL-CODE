Const   ginp='seq.inp';
        gout='seq.out';
        maxn=100001;

Var     n,k,typ:longint;
        a,pos:array[0..maxn] of longint;

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
                        tmp:=pos[i]; pos[i]:=pos[j]; pos[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;


Procedure Enter;
Var     i:longint;
Begin
        readln(n,k);
        if k<0 then
        begin
                typ:=1;
                k:=-k;
        end;
        for i:=1 to n do
        begin
                read(a[i]);
                pos[i]:=i;
        end;
        sort(1,n);
End;

Procedure Process;
Var     i,j:longint;
Begin
        j:=1;
        for i:=1 to n-1 do
        begin
                while (j<n) and ((j<=i) or (a[j]-a[i]<k)) do inc(j);
                if a[j]-a[i]=k then
                begin
                        if typ=1 then write(pos[i],' ',pos[j]) else write(pos[j],' ',pos[i]);
                        exit;
                end;
        end;
        write(0,' ',0);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
