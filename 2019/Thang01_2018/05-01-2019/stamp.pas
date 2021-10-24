Const   ginp='stamp.inp';
        gout='stamp.out';
        maxn=301;
        maxg=10001;

Var     st,n,res:longint;
        a:array[0..maxn,1..4] of longint;
        x:array[0..maxn] of longint;
        d:array[0..maxg] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                for j:=1 to 4 do read(a[i,j]);
                readln;
        end;
End;

Procedure Try(i:longint);
Var     j,sum:longint;
        o:boolean;
Begin
        if i=n+1 then
        begin
                o:=true; sum:=0;
                for i:=1 to n do
                        if x[i]=1 then
                        begin
                                inc(d[a[i,1]]); inc(d[a[i,2]]);
                                sum:=sum+2;
                        end else
                        if x[i]=2 then
                        begin
                                inc(d[a[i,3]]); inc(d[a[i,4]]);
                                sum:=sum+2;
                        end;
                for i:=1 to n do
                begin
                        if (x[i]=1) and (d[a[i,1]] mod 2=0) and (d[a[i,2]] mod 2=0) then o:=false else
                        if (x[i]=2) and (d[a[i,3]] mod 2=0) and (d[a[i,4]] mod 2=0) then o:=false;
                        if not o then break;
                end;
                if (o) and (res<sum) then res:=sum;
                for i:=1 to n do
                        if x[i]=1 then
                        begin
                                d[a[i,1]]:=0; d[a[i,2]]:=0;
                        end else
                        if x[i]=2 then
                        begin
                                d[a[i,3]]:=0; d[a[i,4]]:=0;
                        end;
                exit;
        end;
        for j:=0 to 2 do
        begin
                x[i]:=j;
                try(i+1);
        end;
End;

Procedure Process;
Begin
        res:=0;
        fillchar(d,sizeof(d),0);
        try(1);
        writeln(res);
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
