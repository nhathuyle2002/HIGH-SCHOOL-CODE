Const   ginp='findnum.inp';
        gout='findnum.out';
        maxg=1001000;

Var     n,res:longint;
        d,nt:array[0..maxg] of longint;

Function Pow(a,b:longint):int64;
Var     c:int64;
Begin
        if b=0 then exit(1);
        c:=pow(a,b shr 1);
        pow:=c*c;
        if b and 1=1 then pow:=pow*a;
        if pow>maxg then pow:=0;
End;

Procedure Analys(x:longint);
Begin
        while x>1 do
        begin
                inc(d[nt[x]]);
                x:=x div nt[x];
        end;
End;

Procedure Create;
Var     i,j:longint;
Begin
        fillchar(nt,sizeof(nt),0);
        for i:=2 to maxg do
                if nt[i]=0 then
                begin
                        nt[i]:=i;
                        for j:=i to maxg div i do nt[i*j]:=i;
                end;
End;

Procedure Enter;
Var     i,x:longint;
Begin
        fillchar(d,sizeof(d),0);
        readln(n);
        for i:=1 to n do
        begin
                readln(x);
                analys(x);
        end;
End;

Procedure Process;
Var     i:longint;
        c:int64;
Begin
        res:=maxg;
        for i:=2 to maxg do
                if nt[i]<>i then continue else
                if (d[i]=0) and (i<res) then res:=i else
                if d[i]>0 then
                begin
                        c:=pow(i,d[i]+1);
                        if (c>0) and (c<res) then res:=c;
                end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Create;
        Enter;
        Process;
        Close(input); Close(output);
End.
