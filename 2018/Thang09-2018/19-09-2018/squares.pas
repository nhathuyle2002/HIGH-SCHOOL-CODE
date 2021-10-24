Const   ginp='squares.inp';
        gout='squares.out';
        base=2013;

Var     n,res:int64;

Function Modulo(a,b,c:int64):int64;
Var     c2,c3:boolean;
Begin
        c2:=false; c3:=false;
        if (not c2) and (a mod 2=0) then
        begin
                c2:=true; a:=a div 2;
        end;
        if (not c2) and (b mod 2=0) then
        begin
                c2:=true; b:=b div 2;
        end;
        if (not c2) and (c mod 2=0) then
        begin
                c2:=true; c:=c div 2;
        end;
        if (not c3) and (a mod 3=0) then
        begin
                c3:=true; a:=a div 3;
        end;
        if (not c3) and (b mod 3=0) then
        begin
                c3:=true; b:=b div 3;
        end;
        if (not c3) and (c mod 3=0) then
        begin
                c3:=true; c:=c div 3;
        end;
        a:=a mod base; b:=b mod base; c:=c mod base;
        modulo:=(a*b*c) mod base;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        While not seekeof(input) do
        begin
                readln(n);
                writeln(modulo(n,n+1,2*n+1));
        end;
        Close(input); Close(output);
End.
