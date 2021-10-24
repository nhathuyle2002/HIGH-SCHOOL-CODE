Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e8);

Var     n,m,res:longint;
        maxs:int64;
        a,b,ga,gb:array[0..2010] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(m,n);
        for i:=1 to m do
        begin
                read(a[i]);
                a[i]:=a[i]+a[i-1];
        end;
        readln;
        for i:=1 to n do
        begin
                read(b[i]);
                b[i]:=b[i]+b[i-1];
        end;
        readln;
        read(maxs);
End;

Procedure Process;
Var     i,j:longint;
Begin
        for i:=1 to m do ga[i]:=oo;
        for i:=1 to m do
                for j:=i to m do
                        ga[j-i+1]:=min(ga[j-i+1],a[j]-a[i-1]);
        for i:=1 to n do gb[i]:=oo;
        for i:=1 to n do
                for j:=i to n do
                        gb[j-i+1]:=min(gb[j-i+1],b[j]-b[i-1]);
        res:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if ga[i]*gb[j]<=maxs then res:=max(res,i*j);
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
