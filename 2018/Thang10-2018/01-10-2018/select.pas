Const   ginp='select.inp';
        gout='select.out';
        maxn=1000001;

Var     n:longint;
        res:int64;
        a:ansistring;
        sum:array[0..2*maxn] of longint;
        d:array[-maxn..maxn] of longint;

Procedure Enter;
Begin
        readln(n);
        read(a); a:=a+a;
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0; sum[0]:=0;
        for i:=1 to 2*n-1 do
        begin
                sum[i]:=sum[i-1];
                if a[i]='+' then inc(sum[i]) else dec(sum[i]);
                if i>n then dec(d[sum[i-n]]);
                res:=res+d[sum[i]];
                if (i<=n) and (sum[i]=0) then inc(res);
                if i<n then inc(d[sum[i]]);
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
