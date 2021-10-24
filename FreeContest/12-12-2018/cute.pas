Const   ginp='cute.inp';
        gout='cute.out';
        mn=19;
        mg=1600;

Var     st:longint;
        f,f2:array[0..mn,0..mg] of int64;
        d:array[0..mg] of boolean;
        res,a,b:int64;

Procedure Enter;
Var     i,j,k:longint;
Begin
        f[0,0]:=1;
        for i:=1 to mn do
                for j:=0 to mg do
                        for k:=0 to 9 do
                                if j-k*k>=0 then f[i,j]:=f[i,j]+f[i-1,j-k*k];
        fillchar(d,sizeof(d),true);
        d[0]:=false; d[1]:=false;
        for i:=2 to mg do
                if d[i] then
                        for j:=i to mg div i do d[i*j]:=false;
        for i:=0 to mn do
                for j:=0 to mg do
                        for k:=0 to mg-j do
                                if d[k+j] then f2[i,j]:=f2[i,j]+f[i,k];
End;

Function Calc(x:int64):int64;
Var     i,j,sl:longint;
        p:array[0..mn] of longint;
Begin
        sl:=0;
        while x>0 do
        begin
                inc(sl);
                p[sl]:=x mod 10;
                x:=x div 10;
        end;
        calc:=0;
        for i:=sl-1 downto 1 do
                calc:=calc+f2[i,0];
        x:=0;
        for j:=1 to p[sl]-1 do calc:=calc+f2[sl-1,j*j];
        for i:=sl-1 downto 1 do
        begin
                x:=x+p[i+1]*p[i+1];
                for j:=0 to p[i]-1 do
                        calc:=calc+f2[i-1,x+j*j];
        end;
        x:=x+p[1]*p[1];
        if d[x] then inc(calc);
End;

Procedure Process;
Begin
        readln(a,b);
        res:=calc(b)-calc(a-1);
        writeln(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        readln(st);
        for st:=1 to st do Process;
        Close(input); Close(output);
End.
