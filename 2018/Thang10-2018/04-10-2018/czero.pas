Const   ginp='czero.inp';
        gout='czero.out';
        maxn=32;

Var     k,res,sl:longint;
        n:int64;
        f:array[0..maxn,0..maxn] of longint;

Procedure Create;
Var     i,j:longint;
Begin
        f[0,0]:=1;
        for i:=1 to maxn do
        begin
                f[i,0]:=1; f[i,i]:=1;
                for j:=1 to i-1 do
                        f[i,j]:=f[i-1,j]+f[i-1,j-1];
        end;
End;

Function Getb(x:int64;i:longint):longint;
Begin
        getb:=x shr (i-1) and 1;
End;

Procedure Process;
Var     i,cou,j:longint;
        x:int64;
Begin
        while not seekeof do
        begin
                readln(n,k);
                if k>31 then
                begin
                        writeln(0);
                        continue;
                end;
                x:=n; sl:=0;
                while x>0 do
                begin
                        inc(sl);
                        x:=x shr 1;
                end;
                res:=0; cou:=0;
                for i:=sl-1 downto 1 do
                begin
                        res:=res+f[i-1,k];
                        if getb(n,i)=0 then inc(cou) else
                        if k>cou then res:=res+f[i-1,k-cou-1];
                end;
                if cou=k then inc(res);
                writeln(res);
        end;
End;

Procedure SinhTest;
Var     i,cou,x:longint;
Begin
        n:=2724; k:=4;
        Assign(output,ginp); Rewrite(output);
        writeln(n,' ',k);
        res:=0;
        for i:=1 to n do
        Begin
                cou:=0; x:=i;
                while x>0 do
                begin
                        if x and 1=0 then inc(cou);
                        x:=x shr 1;
                end;
                if cou=k then inc(res);
        End;
        write(res);
        Close(output);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Create;
        Process;
        Close(input); Close(output);
        //SinhTest;
End.
