Uses    Math;

Const   ginp='nrow.inp';
        gout='nrow.out';
        maxn=1001;
        mb=63;
        p:array[1..3,1..3] of longint = ((1,2,3),(2,4,5),(3,5,6));
        base=trunc(1e9);
        mn=70;

Type    bignum= array[0..mn] of int64;

Var     n,res:longint;
        d:array[1..3] of string[3];
        f:array[0..maxn,1..3,0..mb] of bignum;

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

Operator + (a,b:bignum) cong:bignum;
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

Function Getb(i,x:longint):longint;
Begin
        getb:=x shr (i-1) and 1;
End;

Function Daob(i,x:longint):longint;
Begin
        daob:=x xor (1 shl (i-1));
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to 3 do readln(d[i]);
End;

Procedure Process;
Var     i,x,j,j2,y:longint;
Begin
        f[1,1,0]:=doi(1);
        f[1,2,0]:=doi(1);
        f[1,3,0]:=doi(1);
        for i:=2 to n do
        for x:=0 to mb do
                for j:=1 to 3 do
                for j2:=1 to 3 do
                if (d[j,j2]='Y') and (getb(p[j,j2],x)=1) then
                begin
                        y:=daob(p[j,j2],x);
                        f[i,j,x]:=f[i,j,x]+f[i-1,j2,x]+f[i-1,j2,daob(p[j,j2],x)];
                end;
        res:=0;
        for j:=1 to 3 do
        for j2:=j to 3 do
                if d[j,j2]='Y' then res:=daob(p[j,j2],res);
        writeop(f[n,1,res]+f[n,2,res]+f[n,3,res]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
