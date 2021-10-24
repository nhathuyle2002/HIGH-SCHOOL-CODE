Const   ginp='digit.inp';
        gout='digit.out';

Var     a,b,k,res:qword;

Function Modulo(a,b,m:qword):qword;
Begin
        if a=0 then exit(0);
        b:=b mod m;
        modulo:=(modulo(a div 2,b*2,m)+a mod 2*b) mod m;
End;

Function Pow(a,b,m:qword):qword;
Var     c:qword;
Begin
        if b=0 then exit(1 mod m);
        c:=pow(a,b div 2,m);
        pow:=modulo(c,c,m);
        if b mod 2=1 then pow:=modulo(pow,a,m);
End;

Procedure Process;
Begin
        read(a,b,k);
        res:=pow(10,k-1,b);
        res:=modulo(pow(10,k-1,b),a,b)*10 div b;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
