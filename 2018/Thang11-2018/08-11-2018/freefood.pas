Const   ginp='freefood.inp';
        gout='freefood.out';
        maxn=100010;

Var     n,nheap,res:longint;
        maxt,sum:int64;
        a,x,h:array[0..maxn] of longint;

Procedure Push(x:longint);
Var     i,j:longint;
Begin
        inc(nheap);
        i:=nheap;
        while i>1 do
        begin
                j:=i shr 1;
                if h[j]>=x then break;
                h[i]:=h[j];
                i:=j;
        end;
        h[i]:=x;
        sum:=sum+x;
End;

Procedure Pop;
Var     i,j,x:longint;
Begin
        sum:=sum-h[1];
        x:=h[nheap]; dec(nheap);
        i:=1;
        while i*2<=nheap do
        begin
                j:=i*2;
                if (j<nheap) and (h[j+1]>h[j]) then inc(j);
                if h[j]<=x then break;
                h[i]:=h[j];
                i:=j;
        end;
        h[i]:=x;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,maxt);
        for i:=1 to n do readln(x[i],a[i]);
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0; sum:=0;
        for i:=1 to n do
        if x[i]>maxt then break else
        begin
                push(a[i]);
                while sum+x[i]>maxt do pop;
                if nheap>res then res:=nheap;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
