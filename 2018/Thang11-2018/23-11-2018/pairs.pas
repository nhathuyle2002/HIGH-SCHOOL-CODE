Const   ginp='pairs.inp';
        gout='pairs.out';
        maxn=100001;
        base=trunc(1e9)+7;

Var     n:longint;
        sum,res:int64;
        a:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        sum:=0;
        for i:=1 to n do
        begin
                read(a[i]);
                sum:=sum+a[i];
        end;
End;

Function Count(x:longint):longint;
Begin
        count:=1;
        while x>0 do
        begin
                count:=count*10;
                x:=x div 10;
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        for i:=1 to n do
                res:=(res+(sum-a[i]) mod base*count(a[i])+int64(a[i])*(n-1)) mod base;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
