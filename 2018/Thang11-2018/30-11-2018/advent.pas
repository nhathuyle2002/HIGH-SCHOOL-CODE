Uses    Math;

Const   ginp='advent.inp';
        gout='advent.out';
        maxn=2001;
        oo=2*trunc(1e9)+100;

Var     n,maxd:longint;
        h,l:array[0..maxn] of longint;
        f:array[0..maxn,0..maxn] of longint;

Procedure Sort(ll,rr:longint);
Var     i,j,t,tmp:longint;
Begin
        if ll>=rr then exit;
        i:=ll; j:=rr;
        t:=random(rr-ll+1)+ll; t:=h[t]+l[t];
        repeat
                while h[i]+l[i]<t do inc(i);
                while h[j]+l[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=h[i]; h[i]:=h[j]; h[j]:=tmp;
                        tmp:=l[i]; l[i]:=l[j]; l[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(ll,j); sort(i,rr);
End;

Procedure Enter;
Var     i,sum:longint;
Begin
        readln(n);
        sum:=0;
        for i:=1 to n do
        begin
                readln(h[i],l[i]);
                sum:=sum+h[i];
        end;
        sort(1,n);
        read(maxd);
        maxd:=sum-maxd;
End;

Procedure Process;
Var     i,j:longint;
Begin
        f[0,0]:=0;
        for j:=1 to n do f[0,j]:=oo;
        for i:=1 to n do
                for j:=0 to n do
                begin
                        f[i,j]:=f[i-1,j];
                        if (j>0) and (maxd+l[i]>=f[i-1,j-1]) then f[i,j]:=min(f[i,j],f[i-1,j-1]+h[i]);
                end;
        for j:=n downto 0 do
                if f[n,j]<>oo then
                begin
                        write(j);
                        break;
                end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
