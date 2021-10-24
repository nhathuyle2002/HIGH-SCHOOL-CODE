Const   ginp='intsle.inp';
        gout='intsle.out';

Var     st:longint;
        a,b,c:array[1..2] of int64;
        d,dx,dy:int64;

Function Gcd(a,b:int64):int64;
Begin
        if b=0 then exit(a);
        gcd:=gcd(b,a mod b);
End;

Function NN(a,b,c:int64):boolean;
Begin
        if c mod gcd(a,b)=0 then exit(true) else exit(false);
End;

Procedure Enter;
Begin
        readln(a[1],b[1],c[1],a[2],b[2],c[2]);
End;

Procedure Process;
Var     ok:boolean;
Begin
        d:=a[1]*b[2]-a[2]*b[1];
        dx:=c[1]*b[2]-c[2]*b[1];
        dy:=a[1]*c[2]-a[2]*c[1];
        if (sqr(a[1])+sqr(b[1])=0) or (sqr(a[2])+sqr(b[2])=0) then
        begin
                ok:=true;
                if (sqr(a[1])+sqr(b[1])=0) and (c[1]<>0) then ok:=false;
                if (sqr(a[1])+sqr(b[1])<>0) and (not nn(a[1],b[1],c[1])) then ok:=false;
                if (sqr(a[2])+sqr(b[2])=0) and (c[2]<>0) then ok:=false;
                if (sqr(a[2])+sqr(b[2])<>0) and (not nn(a[2],b[2],c[2])) then ok:=false;
                if not ok then writeln('NO SOLUTION') else writeln('INFINITE');
                exit;
        end;
        if d<>0 then
        begin
                if (dx mod d<>0) or (dy mod d<>0) then writeln('NO SOLUTION')
                else writeln(dx div d,' ',dy div d);
        end else
        if d=0 then
        begin
                if (dx<>0) or (dy<>0) then writeln('NO SOLUTION') else
                if not nn(a[1],b[1],c[1]) then writeln('NO SOLUTION') else
                writeln('INFINITE');
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                Process;
        end;
        Close(input); Close(output);
End.
