Uses    Math;

Const   ginp='subseqmax.inp';
        gout='subseqmax.out';
        maxn=1000001;

Var     n:longint;
        res,mins:int64;
        s:array[0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(s[i]);
                s[i]:=s[i]+s[i-1];
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        mins:=0; res:=-trunc(1e17);
        for i:=1 to n do
        begin
                res:=max(res,s[i]-mins);
                mins:=min(mins,s[i]);
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
