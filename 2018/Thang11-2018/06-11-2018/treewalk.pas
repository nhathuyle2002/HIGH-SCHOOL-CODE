Const   ginp='treewalk.inp';
        gout='treewalk.out';
        base=trunc(1e9)+7;

Var     cou,res:int64;
        a:ansistring;

Procedure Enter;
Begin
        read(a);
End;

Procedure Process;
Var     i:longint;
Begin
        res:=1; cou:=1;
        for i:=1 to length(a) do
                if a[i]='L' then res:=(res*2) mod base else
                if a[i]='R' then res:=(res*2+cou) mod base else
                if a[i]='*' then
                begin
                        res:=(res+res*2+res*2+cou) mod base;
                        cou:=(cou*3) mod base;
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
