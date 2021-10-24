Const   ginp='nopass.inp';
        gout='nopass.out';
        maxn=1000010;

Var     n,res,maxp:longint;
        p:array[0..maxn] of longint;

Procedure Enter;
Var     i,x:longint;
        d:array[0..maxn] of longint;
Begin
        readln(n);
        for i:=1 to n do read(p[i]); readln;
        for i:=1 to n do
        begin
                read(x);
                d[x]:=i;
        end;
        for i:=1 to n do p[i]:=d[p[i]];
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0; maxp:=0;
        for i:=1 to n do
        begin
                if p[i]<maxp then inc(res);
                if maxp<p[i] then maxp:=p[i];
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
