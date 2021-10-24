Const   ginp='maxframe.inp';
        gout='maxframe.out';
        maxn=410;
        oo=trunc(1e15);

Var     m,n:longint;
        a,sh,sc:array[0..maxn,0..maxn] of int64;
        res:int64;
        gmax:array[0..maxn] of int64;

function max(x,y:int64):int64;
begin
        if x>y then max:=x else max:=y;
end;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        sh[i,j]:=sh[i,j-1]+a[i,j];
                        sc[i,j]:=sc[i-1,j]+a[i,j];
                end;
                readln;
        end;
End;

Procedure Process;
Var     i1,i2,j:longint;
        smax:int64;
Begin
        res:=-oo;
        for i1:=1 to m-1 do
        for i2:=i1+1 to m do
        begin
                gmax[0]:=-oo; smax:=-oo;
                for j:=1 to n-1 do gmax[j]:=max(gmax[j-1],sc[i2-1,j]-sc[i1,j]-sh[i1,j-1]-sh[i2,j-1]);
                for j:=n downto 2 do
                begin
                        smax:=max(smax,sc[i2-1,j]-sc[i1,j]-sh[i1,n]+sh[i1,j]-sh[i2,n]+sh[i2,j]);
                        res:=max(res,smax+gmax[j-1]+sh[i1,n]+sh[i2,n]);
                end;
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
