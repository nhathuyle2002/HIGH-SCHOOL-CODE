Const   ginp='adds.inp';
        gout='adds.out';

Var     a,b,m,res:int64;

Procedure Enter;
Begin
        read(a,b,m);
End;

Function C3(x,y,z:int64):int64;
Begin
        if x mod 3=0 then x:=x div 3 else
        if y mod 3=0 then y:=y div 3 else
        if z mod 3=0 then z:=z div 3;
        c3:=x*y mod m*z mod m;
End;

Procedure Process;
Begin
        res:=c3(b,b+1,b+2)-b*(b+1) div 2-c3(a-1,a,a+1)+(a-1)*a div 2;
        res:=(res mod m+m) mod m;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
