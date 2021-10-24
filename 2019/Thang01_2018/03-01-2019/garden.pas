Uses    Math;

Const   ginp='garden.inp';
        gout='garden.out';
        maxn=2010;

Var     st,m,n,w,res:longint;
        l:extended;
        a,b:array[0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(l,w);
        readln(m);
        for i:=1 to m do read(a[i]); readln;
        readln(n);
        for i:=1 to n do read(b[i]); readln;
End;

Function Dis(x,y:int64):extended;
Begin
        dis:=sqrt(sqr(abs(x-y))+sqr(w));
End;

Procedure Process;
Var     i1,i2,j1,j2:longint;
        d:extended;
Begin
        res:=0;
        for i1:=1 to m do
        for j1:=1 to n do
        begin
                j2:=n;
                for i2:=i1 to m do
                begin
                        d:=a[i2]-a[i1]+dis(a[i1],b[j1]);
                        while (j2>=j1) and (d+b[j2]-b[j1]+dis(a[i2],b[j2])>l) do dec(j2);
                        if j2<j1 then break;
                        res:=max(res,i2-i1+1+j2-j1+1);
                end;
        end;
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
