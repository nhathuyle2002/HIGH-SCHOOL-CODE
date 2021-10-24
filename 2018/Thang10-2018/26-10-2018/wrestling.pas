Const   ginp='wrestling.inp';
        gout='wrestling.out';
        maxn=500010;

Var     n,res:longint;
        pos,c,d:array[0..maxn] of longint;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(x);
                pos[x]:=i;
        end;
        readln;
        for i:=1 to n do
        begin
                read(x);
                c[i]:=pos[x];
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        for i:=1 to n do
                if c[i]>i then inc(d[i-c[i]+n]) else inc(d[i-c[i]]);
        res:=0;
        for i:=1 to n-1 do
                if d[res]<d[i] then res:=i;
        write(res,' ',d[res]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
