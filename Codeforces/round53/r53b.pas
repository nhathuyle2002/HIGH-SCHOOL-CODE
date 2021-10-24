Const   ginp='ss.inp';
        gout='ss.out';
        maxn=200010;

Var     n:longint;
        a,b,d:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i]);
                d[a[i]]:=i;
        end;
        readln;
        for i:=1 to n do read(b[i]);
End;

Procedure Process;
Var     i,maxd:longint;
Begin
        maxd:=0;
        for i:=1 to n do
                if d[b[i]]<maxd then write(0,' ') else
                begin
                        write(d[b[i]]-maxd,' ');
                        maxd:=d[b[i]];
                end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
