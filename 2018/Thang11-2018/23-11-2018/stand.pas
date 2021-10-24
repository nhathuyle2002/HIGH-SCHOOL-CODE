Const   ginp='stand.inp';
        gout='stand.out';
        maxn=7001;

Var     mx,my,q:longint;
        f,d:array[-1..maxn,-1..maxn] of longint;

Procedure Swap(var x,y:longint);
Var     tmp:longint;
Begin
        tmp:=x; x:=y; y:=tmp;
End;

Procedure Enter;
Var     x,y,k:longint;
Begin
        readln(mx,my,q);
        for x:=1 to mx do
                for y:=1 to my do
                begin
                        if (d[x,y]=0) and (sqrt(x*x+y*y)=trunc(sqrt(x*x+y*y))) then f[x,y]:=1 else f[x,y]:=0;
                        f[x,y]:=f[x,y]+f[x,y-1]+f[x-1,y]-f[x-1,y-1];
                        if d[x,y]=0 then
                        begin
                                k:=2;
                                while (x*k<=mx) and (y*k<=my) do
                                begin
                                        d[x*k,y*k]:=1;
                                        inc(k);
                                end;
                        end;
                end;
End;

Procedure Process;
Var     i,x1,x2,y1,y2:longint;
Begin
        for i:=1 to q do
        begin
                readln(x1,y1,x2,y2);
                if x1>x2 then swap(x1,x2);
                if y1>y2 then swap(y1,y2);
                writeln(f[x2,y2]-f[x1-1,y2]-f[x2,y1-1]+f[x1-1,y1-1]);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
