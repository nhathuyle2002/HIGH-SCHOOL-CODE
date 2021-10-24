Const   ginp='ss.inp';
        gout='ss.out';
        maxn=201;

Var     n:longint;
        ok:boolean;
        a,res:array[0..maxn,0..maxn] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n);
        for i:=2 to n do
        begin
                for j:=2 to n do read(a[i,j]);
                readln;
        end;
End;

Procedure Try(k:longint);
Var     i,j,p:longint;
        o:boolean;
Begin
        if k>n then
        begin
                ok:=true;
                exit;
        end;
        for i:=0 to 1 do
        for j:=0 to 1 do
        begin
                res[1,k]:=i; res[k,1]:=j;
                o:=true;
                for p:=2 to k-1 do
                begin
                        res[p,k]:=a[p,k]-res[p,k-1]-res[p-1,k]-res[p-1,k-1];
                        if (res[p,k]<0) or (res[p,k]>1) then
                        begin
                                o:=false;
                                break;
                        end;
                end;
                if not o then continue;
                for p:=2 to k do
                begin
                        res[k,p]:=a[k,p]-res[k,p-1]-res[k-1,p]-res[k-1,p-1];
                        if (res[k,p]<0) or (res[k,p]>1) then
                        begin
                                o:=false;
                                break;
                        end;
                end;
                if not o then continue else
                begin
                        try(k+1);
                        if ok then exit;
                end;
        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        ok:=false;
        res[1,1]:=0;
        try(2);
        if not ok then
        begin
                res[1,1]:=1;
                try(2);
        end;
        if not ok then write('No solution') else
        for i:=1 to n do
        begin
                for j:=1 to n do write(res[i,j],' ');
                writeln;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
