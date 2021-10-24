Const   ginp='expression.inp';
        gout='expression.out';
        maxn=101;
        maxg=10001;

Var     n,gg:longint;
        a:array[0..maxn] of longint;
        d:array[0..maxn,-maxg..maxg] of boolean;
        res:string;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,gg);
        for i:=1 to n do read(a[i]);
End;

Procedure Process;
Var     i,j:longint;
Begin
        fillchar(d,sizeof(d),false);
        d[1,a[1]]:=true;
        for i:=2 to n do
                for j:=-maxg to maxg do
                        if ((j-a[i]>=-maxg) and (d[i-1,j-a[i]])) or ((j+a[i]<=maxg) and (d[i-1,j+a[i]])) then d[i,j]:=true;
        res:='';
        j:=gg;
        for i:=n downto 2 do
                if (j-a[i]>=-maxg) and (d[i-1,j-a[i]]) then
                begin
                        res:='+'+res;
                        j:=j-a[i];
                end else
                begin
                        res:='-'+res;
                        j:=j+a[i];
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
