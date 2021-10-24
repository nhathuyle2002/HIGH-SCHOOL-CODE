Const   ginp='exp3.inp';
        gout='exp3.out';
        maxn=21;
        maxb=1 shl 18+1;
        base1=trunc(1e9)+7;
        base2=trunc(1e9)+13;

Var     n,nn,res:longint;
        a1,a2:array[0..maxn] of int64;
        h1,h2:array[0..maxb] of int64;

Procedure Sort(l,r:longint);
Var     i,j:longint;
        t1,t2,tmp:int64;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t1:=random(r-l+1)+l;
        t2:=h2[t1]; t1:=h1[t1];
        repeat
                while (h1[i]<t1) or ((h1[i]=t1) and (h2[i]<t2)) do inc(i);
                while (h1[j]>t1) or ((h1[j]=t1) and (h2[j]>t2)) do dec(j);
                if i<=j then
                begin
                        tmp:=h1[i]; h1[i]:=h1[j]; h1[j]:=tmp;
                        tmp:=h2[i]; h2[i]:=h2[j]; h2[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Try(ii:longint; mul1,mul2:int64);
Var     i:longint;
Begin
        inc(nn);
        h1[nn]:=mul1; h2[nn]:=mul2;
        for i:=ii+1 to n do try(i,mul1*a1[i] mod base1,mul2*a2[i] mod base2);
End;

Procedure Enter;
Var     i:longint;
Begin
        read(n);
        for i:=1 to n do
        begin
                read(a1[i]);
                a2[i]:=a1[i] mod base2;
                a1[i]:=a1[i] mod base1;
        end;
        readln;
End;

Procedure Process;
Var     i:longint;
Begin
        nn:=0;
        try(2,1,1);
        sort(1,nn);
        res:=0;
        for i:=1 to nn do
                if (h1[i]<>h1[i-1]) or (h2[i]<>h2[i-1]) then inc(res);
        writeln(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        while not seekeof do
        begin
                Enter;
                Process;
        end;
        Close(input); Close(output);
End.
