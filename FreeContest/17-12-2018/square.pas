Uses    Math;

Const   ginp='square.inp';
        gout='square.out';

Var     st,n,res:longint;
        hmin,hmax,wmin,wmax:longint;

Function Ltl(x:real):longint;
Begin
        if trunc(x)=x then ltl:=trunc(x) else ltl:=trunc(x)+1;
End;

Function Ltx(x:real):longint;
Begin
        ltx:=trunc(x);
End;

Procedure Process;
Var     i,l,r,x:longint;
Begin
        if hmax>wmax then
        begin
                i:=hmax; hmax:=wmax; wmax:=i;
                i:=hmin; hmin:=wmin; wmin:=i;
        end;
        n:=trunc(sqrt(hmax))+1;
        res:=0;
        for i:=1 to n do
                if (hmax div i>(hmin-1) div i) and (wmax div i>(wmin-1) div i) then res:=i;
        for i:=1 to n do
        begin
                l:=ltl(hmin/i); r:=ltx(hmax/i);
                if (l=0) or (l>r) then continue;
                x:=ltx(wmax/r);
                if x*r>=wmin then res:=max(res,r);
                inc(x);
                if (x*l<=wmax) and (ltx(wmax/x)*x>=wmin) then res:=max(res,ltx(wmax/x));
        end;
        writeln(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                readln(hmin,hmax,wmin,wmax);
                Process;
        end;
        Close(input); Close(output);
End.
