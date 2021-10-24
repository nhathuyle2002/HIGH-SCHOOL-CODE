Uses    Math;

Const   ginp='balance.inp';
        gout='balance.out';
        maxn=101;
        maxg=maxn*maxn+100;
        base=trunc(1e9);
        mn=10;

Type    bignum= array[0..mn] of int64;

Var     n,m:longint;
        f:array[0..maxn,-maxg..maxg] of bignum;

Function Doi(x:longint):bignum;
Begin
        doi[0]:=0;
        while x>0 do
        begin
                inc(doi[0]);
                doi[doi[0]]:=x mod 10;
                x:=x div 10;
        end;
End;

Function Cong(a,b:bignum):bignum;
Var     i,nho:longint;
Begin
        cong[0]:=max(a[0],b[0]);
        nho:=0;
        for i:=1 to cong[0] do
        begin
                if i>a[0] then a[i]:=0;
                if i>b[0] then b[i]:=0;
                cong[i]:=a[i]+b[i]+nho;
                nho:=cong[i] div base;
                cong[i]:=cong[i] mod base;
        end;
        if nho>0 then
        begin
                inc(cong[0]);
                cong[cong[0]]:=nho;
        end;
End;

Procedure Enter;
Begin
        read(n,m);
End;

Procedure WriteOP(x:bignum);
Var     i:longint;
        s:string[10];
Begin
        write(x[x[0]]);
        for i:=x[0]-1 downto 1 do
        begin
                str(x[i],s);
                while length(s)<9 do s:='0'+s;
                write(s);
        end;
End;

Procedure Process;
Var     i,j,mg:longint;
Begin
        f[0,-m]:=doi(1);
        for i:=1 to n do
        begin
                mg:=i*(i+1) div 2;
                for j:=-mg-m to mg-m do
                begin
                        f[i,j]:=f[i-1,j];
                        if j-i>=-maxg then f[i,j]:=cong(f[i,j],f[i-1,j-i]);
                        if j+i<=maxg then f[i,j]:=cong(f[i,j],f[i-1,j+i]);
                end;
        end;
        writeop(f[n,0]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
