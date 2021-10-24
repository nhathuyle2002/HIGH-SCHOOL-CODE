Const   ginp='fans.inp';
        gout='fans.out';

Var     st,n,m,res:longint;
        s:ansistring;
        a,x:array[0..1000] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        readln(s);
        for i:=1 to n do
                if s[i]='V' then a[i]:=1 else a[i]:=-1;
End;

Procedure Try(i:longint; ok:boolean);
Var     j,sum:longint;
Begin
        sum:=0;
        for j:=i-1 downto 1 do
        begin
                sum:=sum+x[j];
                if abs(sum)>2 then exit;
        end;
        if i=n+1 then
        begin
                inc(res);
                exit;
        end;
        if ok then
        begin
                x[i]:=1; try(i+1,true);
                x[i]:=-1; try(i+1,true);
        end else
        if a[i]=1 then
        begin
                x[i]:=1; try(i+1,false);
                x[i]:=-1; try(i+1,true);
        end else
        begin
                x[i]:=-1; try(i+1,false);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                res:=0;
                try(1,false);
                if m=0 then writeln(res) else writeln(res mod m);
        end;
        Close(input); Close(output);
End.
