Type    Matrix= array[1..3,1..3] of int64;

Const   ginp='loco.inp';
        gout='loco.out';
        dv:matrix= ((1,0,0),(0,1,0),(0,0,1));
        d:matrix= ((1,1,1),(1,0,0),(0,1,0));

Var     n,base:int64;
        res:matrix;

Operator * (a,b:matrix) c:matrix;
Var     i,j,k:longint;
Begin
        fillchar(c,sizeof(c),0);
        for i:=1 to 3 do
                for j:=1 to 3 do
                        for k:=1 to 3 do
                                c[i,j]:=(c[i,j]+a[i,k]*b[k,j]) mod base;
End;

Function Pow(a:matrix; p:int64):matrix;
Var     c:matrix;
Begin
        if p=0 then exit(dv);
        c:=pow(a,p div 2);
        pow:=c*c;
        if p mod 2=1 then pow:=pow*a;
End;

Procedure Enter;
Begin
        read(n,base);
End;

Procedure Process;
Begin
        res:=pow(d,n);
        write(res[1,1]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
