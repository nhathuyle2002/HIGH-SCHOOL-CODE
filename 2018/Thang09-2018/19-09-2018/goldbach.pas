Const   ginp='goldbach.inp';
        gout='goldbach.out';

Var     n:longint;

Function Check(x:longint):boolean;
var     i:longint;
begin
        for i:=2 to trunc(sqrt(x)) do
                if x mod i=0 then exit(false);
        exit(true);
end;

Procedure Process;
Var     i:longint;
Begin
        read(n);
        for i:=n div 2 downto 1 do
                if check(i) and check(n-i) then break;
        write(i,' ',n-i);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
