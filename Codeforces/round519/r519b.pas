Const   ginp='ss.inp';
        gout='ss.out';
        maxn=1001;

Var     n,cou:longint;
        c,a,ou:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(c[i]);
                a[i]:=c[i]-c[i-1];
        end;
End;

Procedure Process;
Var     i,k:longint;
        ok:boolean;
Begin
        cou:=0;
        for k:=1 to n do
        begin
                ok:=true;
                for i:=1 to n do
                        if (i>k) and (a[i]<>a[i-k]) then
                        begin
                                ok:=false;
                                break;
                        end;
                if ok then
                begin
                        inc(cou);
                        ou[cou]:=k;
                end;
        end;
        writeln(cou);
        for i:=1 to cou do write(ou[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
