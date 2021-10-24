{$MODE OBJFPC}

Uses    Math;

Const   ginp='cwater.inp';
        gout='cwater.out';

Var     st:longint;
        a,b,c,x,p:int64;

Procedure Enter;
Var     tmp:int64;
Begin
        readln(a,b,c);
        if a>b then
        begin
                tmp:=a; a:=b; b:=tmp;
        end;
End;

Function Diophante(a,b,c:int64; var x,p:int64):boolean;
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
        p:=abs(b div m);
        x:=xm*q mod p;
        if x<=0 then x:=x+p;
End;

Function Process:int64;
Begin
        if not diophante(a,b,c,x,p) then result:=-1 else
        result:=min(x+abs((c-a*x) div b),abs(x-p)+(c-a*(x-p)) div b);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                writeln(Process);
        end;
        Close(input); Close(output);
End.
