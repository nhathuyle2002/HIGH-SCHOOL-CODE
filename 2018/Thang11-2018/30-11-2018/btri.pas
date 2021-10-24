Const   ginp='btri.inp';
        gout='btri.out';
        maxg=1001;

Var     n:longint;
        res:int64;
        d:array[0..maxg] of int64;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(x);
                inc(d[x]);
        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        res:=0;
        res:=d[0]*(d[0]-1)*(d[0]-2) div 6;
        for i:=1 to maxg do
        begin
                res:=res+d[0]*d[i]*(d[i]-1) div 2;
                if 2*i<=maxg then res:=res+d[i]*(d[i]-1)*d[2*i] div 2;
        end;
        for i:=1 to maxg do
                for j:=i+1 to maxg-i do
                        res:=res+d[i]*d[j]*d[i+j];
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
