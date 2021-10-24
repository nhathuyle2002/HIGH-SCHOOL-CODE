Uses    Math;

Const   ginp='game.inp';
        gout='game.out';
        maxn=1001;
        base=trunc(1e9);

Type    bignum= array[0..4] of longint;

Var     n,m,kk:longint;
        sum:array[0..maxn,0..maxn] of bignum;

Function C_h(x:longint):bignum;
Begin
        c_h[0]:=0;
        while x>0 do
        begin
                inc(c_h[0]);
                c_h[c_h[0]]:=x mod base;
                x:=x div base;
        end;
End;

Operator + (a,b:bignum) c:bignum;
Var     i,nho:longint;
Begin
        c[0]:=max(a[0],b[0]);
        nho:=0;
        for i:=1 to c[0] do
        begin
                if i>a[0] then a[i]:=0;
                if i>b[0] then b[i]:=0;
                c[i]:=a[i]+b[i]+nho;
                if c[i]<base then nho:=0 else
                begin
                        nho:=1;
                        c[i]:=c[i]-base;
                end;
        end;
        if nho>0 then
        begin
                inc(c[0]);
                c[c[0]]:=nho;
        end;
End;

Procedure Enter;
Begin
        readln(n,m,kk);
End;

Procedure Writeop(x:bignum);
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
        writeln;
End;

Procedure Process;
Var     i,j,k:longint;
Begin
        sum[0,0]:=c_h(1);
        for k:=0 to kk do
                for i:=1 to m do
                        for j:=0 to n do
                                if j-k>=0 then sum[i,j]:=sum[i,j]+sum[i-1,j-k];
        writeop(sum[m,n]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
