{$MODE OBJFPC}

Const   ginp='countmod.inp';
        gout='countmod.out';

Var     st:longint;
        a,b:array[1..7] of int64;

Function Diophante(a,b,c:int64; var xx,lcm:int64):boolean;
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
        lcm:=abs(a div m*b);
        q:=lcm div a;
        xx:=(c div m*xm mod q+q) mod q;
End;

Function Solve(a1,b1,a2,b2:int64; var x,lcm:int64):boolean;
Begin
        result:=diophante(a1,-a2,b2-b1,x,lcm);
        if not result then exit;
        x:=(a1*x+b1) mod lcm;
End;

Procedure Enter;
Var     i:longint;
Begin
        for i:=1 to 4 do readln(a[i],b[i]);
End;

Function Process:int64;
Begin
        if not solve(a[1],b[1],a[2],b[2],b[5],a[5]) then exit(-1);
        if not solve(a[3],b[3],a[4],b[4],b[6],a[6]) then exit(-1);
        if not solve(a[5],b[5],a[6],b[6],b[7],a[7]) then exit(-1);
        result:=b[7];
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        while st>0 do
        begin
                Enter;
                writeln(Process);
                dec(st);
        end;
        Close(input); Close(output);
End.
