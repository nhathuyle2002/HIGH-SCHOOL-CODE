Const   ginp='clist.inp';
        gout='clist.out';
        maxn=100010;

Var     n,k,l:longint;
        a:array[0..2*maxn] of longint;
        x,y:qword;

Function Pow(a,b:qword):qword;
Begin
        if b=0 then exit(0);
        pow:=(pow((2*a) mod n,b div 2)+a*(b mod 2)) mod n;
End;

Procedure Process;
Var     i:longint;
Begin
        readln(n,k,l);
        for i:=1 to n do
        begin
                read(a[i]); a[i+n]:=a[i];
        end;
        readln; read(x);
        y:=abs(k-l);
        y:=pow(y,x);
        if k>=l then
                for i:=y+1 to n+y do write(a[i],' ')
        else
                for i:=n-y+1 to 2*n-y do write(a[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Process;
        Close(input); Close(output);
End.
