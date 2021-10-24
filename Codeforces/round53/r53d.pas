Const   ginp='ss.inp';
        gout='ss.out';
        maxn=200010;

Var     n:longint;
        mt,res:int64;
        a,rr:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,mt);
        rr[0]:=1;
        for i:=1 to n do
        begin
                read(a[i]);
                rr[i]:=i+1;
        end;
End;

Procedure Process;
Var     i,j,cou:longint;
        sum:int64;
Begin
        repeat
                sum:=0; cou:=0;
                j:=0;
                repeat
                        i:=rr[j];
                        while (i<=n) and (a[i]>mt) do i:=rr[i];
                        rr[j]:=i;
                        if i>n then break;
                        mt:=mt-a[i];
                        sum:=sum+a[i];
                        inc(cou);
                        j:=i;
                until false;
                if sum=0 then break;
                res:=res+int64(mt div sum+1)*cou;
                mt:=mt mod sum;
        until false;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
