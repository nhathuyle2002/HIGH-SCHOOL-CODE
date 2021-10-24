Const   ginp='ep.inp';
        gout='ep.out';
        maxn=1000001;

Var     st,a,b:longint;
        res:int64;
        d,f:array[0..maxn] of longint;
        dd:array[0..maxn] of boolean;

Procedure Sangnt;
Var     i,j:longint;
Begin
        for i:=2 to maxn do
                if d[i]=0 then
                begin
                        d[i]:=i;
                        for j:=i to maxn div i do d[i*j]:=i;
                end;
End;

Procedure Pt(x:longint);
Var     mul,y:longint;
Begin
        y:=x; mul:=1;
        while x>1 do
        begin
                if not dd[d[x]] then
                begin
                        mul:=mul*d[x];
                        dd[d[x]]:=true;
                end;
                x:=x div d[x];
        end;
        x:=y;
        while x>1 do
        begin
                dd[d[x]]:=false;
                x:=x div d[x];
        end;
        inc(f[mul]);
End;

Procedure Process;
Var     i:longint;
Begin
        readln(a,b);
        fillchar(f,sizeof(f),0);
        fillchar(dd,sizeof(dd),false);
        for i:=a to b do
        pt(i);
        res:=0;
        for i:=2 to maxn do
                res:=res+int64(f[i])*(f[i]-1) div 2;
        writeln(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Sangnt;
        readln(st);
        for st:=1 to st do Process;
        Close(input); Close(output);
End.
