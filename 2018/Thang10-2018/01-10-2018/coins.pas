Uses    Math;

Const   ginp='coins.inp';
        gout='coins.out';
        base=round(1e9);
        maxn=7;

Type    bignum= array[0..maxn] of longint;

Var     n:longint;
        f:array[0..100010] of bignum;

Operator + (x,y:bignum) z:bignum;
Var     i,nho:longint;
Begin
        z[0]:=max(x[0],y[0]);
        nho:=0;
        for i:=1 to z[0] do
        begin
                if i>x[0] then x[i]:=0;
                if i>y[0] then y[i]:=0;
                z[i]:=x[i]+y[i]+nho;
                if z[i]<base then nho:=0 else
                begin
                        nho:=1;
                        z[i]:=z[i]-base;
                end;
        end;
        if nho>0 then
        begin
                inc(z[0]);
                z[z[0]]:=nho;
        end;
End;

Procedure Enter;
Begin
        read(n);
End;

Procedure Process;
Var     i,j:longint;
        a:string[10];
Begin
        f[0,0]:=1; f[0,1]:=1;
        for j:=1 to 100 do
                for i:=1 to n do
                        if i-j*j>=0 then f[i]:=f[i]+f[i-j*j];
        write(f[n,f[n,0]]);
        for i:=f[n,0]-1 downto 1 do
        begin
                str(f[n,i],a);
                while length(a)<9 do a:='0'+a;
                write(a);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
