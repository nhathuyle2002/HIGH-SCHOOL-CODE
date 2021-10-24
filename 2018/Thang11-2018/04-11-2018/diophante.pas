{$MODE OBJFPC}

Const   ginp='diophante.inp';
        gout='diophante.out';

Var     a,b,c,x,k:int64;

Function Diophante(a,b,c:int64; var x,k:int64):boolean;
Var     m,n,r,xm,xn,xr,q:int64;
Begin
        m:=a; n:=b;
        xm:=1; xn:=0;
        while n<>0 do
        begin
                q:=m div n;
                r:=m-q*n;
                xr:=xm-q*xn;
                m:=n; xm:=xn;
                n:=r; xn:=xr;
        end;
        result:=c mod m=0;
        if not result then exit;
        q:=c div m;
        k:=abs(b div m);
        x:=xm*q mod k;
        if x<=0 then x:=x+k;
End;

Function Process:int64;
Begin
        read(a,b,c);
        result:=0;
        if (diophante(a,b,c,x,k)) and (x<=(c-b) div a) then result:=((c-b) div a-x) div k+1;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        write(Process);
        Close(input); Close(output);
End.
