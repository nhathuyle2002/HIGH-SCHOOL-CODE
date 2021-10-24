Const   ginp='digit.inp';
        gout='digit.out';

Var     a,b,k:qword;
        rr:qword;

Function Mulmod(a,b,m:qword):qword;
Begin
        if b=0 then exit(0);
        mulmod:=mulmod((a*10) mod m,b div 10,m)+b mod 10*a mod m;
        mulmod:=mulmod mod m;
End;

Function Pow(a,b,m:qword):qword;
Begin
        if b=0 then exit(1);
        pow:=pow(a,b div 2,m);
        pow:=mulmod(pow,pow,m);
        if b mod 2=1 then pow:=mulmod(pow,a,m);
End;

Procedure Process;
Begin
        read(a,b,k);
        if k>0 then a:=mulmod(a,pow(10,k-1,b),b);
        write(a*10 div b);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
