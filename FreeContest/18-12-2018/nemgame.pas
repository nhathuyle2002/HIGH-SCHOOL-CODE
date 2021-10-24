Const   ginp='nemgame.inp';
        gout='nemgame.out';
        maxn=500010;

Var     n:longint;
        res:int64;
        s,d:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(s[i]);
                s[i]:=s[i] xor s[i-1];
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        d[0]:=1;
        for i:=1 to n do
        begin
                inc(d[s[i]]);
                res:=res+d[s[n] xor s[i]];
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
