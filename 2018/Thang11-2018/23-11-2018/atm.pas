Const   ginp='atm.inp';
        gout='atm.out';
        dd:array[1..4] of longint = (1,2,3,5);

Var     st,k:longint;
        n,res,cres:int64;
        d,c:array[0..10] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        d[0]:=0; c[0]:=1;
        for i:=1 to 10 do d[i]:=11;
        for j:=1 to 4 do
                for i:=dd[j] to 10 do
                        if d[i-dd[j]]+1<d[i] then
                        begin
                                d[i]:=d[i-dd[j]]+1;
                                c[i]:=c[i-dd[j]];
                        end else
                        if d[i-dd[j]]+1=d[i] then c[i]:=c[i]+c[i-dd[j]];
End;

Procedure Process;
Var     cou:longint;
Begin
        readln(st);
        for st:=1 to st do
        begin
                readln(n,k);
                if n mod 1000<>0 then writeln(0) else
                begin
                        n:=n div 1000; cou:=0;
                        res:=0; cres:=1;
                        while cou<k do
                        begin
                                res:=res+d[n mod 10];
                                cres:=cres*c[n mod 10];
                                n:=n div 10;
                                inc(cou);
                        end;
                        if n<5 then
                        begin
                                res:=res+d[n];
                                cres:=cres*c[n];
                        end else
                        begin
                                res:=res+n div 5;
                                res:=res-1+d[n mod 5+5];
                                cres:=cres*c[n mod 5+5];
                        end;
                        writeln(res,' ',cres);
                end;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
