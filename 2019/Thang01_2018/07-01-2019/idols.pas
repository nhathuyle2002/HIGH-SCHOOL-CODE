Const   ginp='idols.inp';
        gout='idols.out';
        maxn=100010;

Var     n,res:longint;
        d:array[0..maxn] of longint;

Procedure Process;
Var     i,j,k,x:longint;
Begin
        readln(n);
        res:=0;
        for i:=1 to n do
        begin
                read(k);
                for j:=1 to k do
                begin
                        read(x);
                        inc(d[x]);
                        if d[x]>res then res:=d[x];
                end;
                readln;
        end;
        for i:=1 to n do
                if d[i]=res then write(i,' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
