Const   ginp='table.inp';
        gout='table.out';

Var     n,k:longint;

Procedure Enter;
Begin
        read(n,k);
End;

Function Check(x:longint):longint;
Var     i,cou,xx:longint;
Begin
        check:=1;
        xx:=x;
        for i:=2 to xx do
        begin
                cou:=0;
                while (x>0) and (x mod i=0) do
                begin
                        inc(cou);
                        x:=x div i;
                end;
                check:=check*(cou+1);
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        for i:=1 to n*n do
        begin
                if check(i)>k then write('.') else write('*');
                if i mod n=0 then writeln;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
