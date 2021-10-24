Const   ginp='ss.inp';
        gout='ss.out';
        base=trunc(1e9)+7;

Type    matrix=array[0..51,0..51] of int64;

Var     n,k:longint;
        d:matrix;
        res:int64;

Operator * (a,b:matrix) c:matrix;
Var     i,j,t:longint;
Begin
        fillchar(c,sizeof(c),0);
        for i:=0 to k+1 do
                for j:=0 to k+1 do
                        for t:=0 to k+1 do
                                c[i,j]:=(c[i,j]+a[i,t]*b[t,j]) mod base;
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n,k);
        fillchar(d,sizeof(d),0);
        d[0,0]:=1;
        for i:=1 to k do
        begin
                d[i,0]:=1;
                for j:=1 to i do
                        d[i,j]:=(d[i-1,j]+d[i-1,j-1]) mod base;
        end;
        d[k+1,k]:=1; d[k+1,k+1]:=1;
End;

Function Pow(i:longint):matrix;
Var     c:matrix;
Begin
        if i=1 then exit(d);
        c:=pow(i shr 1);
        pow:=c*c;
        if i and 1=1 then pow:=pow*d;
End;

Procedure Process;
Var     i:longint;
        c:matrix;
Begin
        if n=1 then writeln(1) else
        begin
                c:=pow(n);
                res:=0;
                for i:=0 to k do
                        res:=(res+c[k+1,i]) mod base;
                writeln(res);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        while not seekeof do
        begin
                Enter;
                Process;
        end;
        Close(input); Close(output);
End.
