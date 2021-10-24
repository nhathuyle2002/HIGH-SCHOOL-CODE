Uses    Math;

Const   ginp='squares.inp';
        gout='squares.out';

Var     res:int64;
        m,n,k:longint;
        x,y:array[0..101] of longint;
        d:array[0..1001,0..1001] of boolean;
        f:array[1..4] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(m,n,k);
        fillchar(d,sizeof(d),false);
        for i:=1 to k do
        begin
                readln(x[i],y[i]);
                d[x[i],y[i]]:=true;
        end;
End;

Procedure Check(ii,i,j:longint);
Var     cou,a,b:longint;
Begin
        cou:=1;
        if d[i,j] then inc(cou);
        a:=i-x[ii]; b:=j-y[ii];
        i:=i-b; j:=j+a;
        if (i<1) or (j<1) or (i>m) or (j>n) then exit else
        if d[i,j] then inc(cou);
        i:=i-a; j:=j-b;
        if (i<1) or (j<1) or (i>m) or (j>n) then exit else
        if d[i,j] then inc(cou);
        inc(f[cou]);
End;

Procedure Process;
Var     ii,i,j:longint;
Begin
        res:=0;
        for i:=1 to m-1 do
        for j:=1 to n-1 do
                if i+j<min(m,n) then res:=res+(m-i-j)*(n-i-j);
        for i:=1 to m-1 do
        for j:=1 to n-1 do
                res:=res+min(i,j);
        for ii:=1 to k do
                for i:=1 to m do
                for j:=1 to n do
                        if (i<>x[ii]) or (j<>y[ii]) then check(ii,i,j);
        for i:=1 to 4 do res:=res-f[i] div i;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
