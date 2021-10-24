Const   ginp='minsum.inp';
        gout='minsum.out';
        maxn=51;
        oo=trunc(1e9);

Var     n,st:longint;
        a:array[0..maxn] of longint;

Procedure Process;
Var     i,ma1,ma2,mi1,mi2:longint;
Begin
        for i:=1 to n do read(a[i]); readln;
        ma1:=0; ma2:=0; mi1:=oo; mi2:=oo;
        for i:=1 to n do
        begin
                if a[i]<=mi1 then
                begin
                        mi2:=mi1;
                        mi1:=a[i];
                end else
                if a[i]<mi2 then mi2:=a[i];
                if a[i]>=ma1 then
                begin
                        ma2:=ma1;
                        ma1:=a[i];
                end else
                if a[i]>ma2 then ma2:=a[i];
        end;
        if mi1/ma2<mi2/ma1 then writeln(mi1,' ',ma2,' ',mi2,' ',ma1)
        else writeln(mi2,' ',ma1,' ',mi1,' ',ma2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st,n);
        while st>0 do
        begin
                Process;
                dec(st);
        end;
        Close(input); Close(output);
End.
