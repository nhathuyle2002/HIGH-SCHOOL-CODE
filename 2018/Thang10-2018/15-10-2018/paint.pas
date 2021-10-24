Const   ginp='paint.inp';
        gout='paint.out';
        base=1000000007;
        maxn=2010;

Var     m,n,r,c,res:longint;
        sumb,modul:int64;
        pow,inv:array[0..maxn*maxn] of int64;
        a,b:array[0..maxn] of ansistring;
        sum:array[0..maxn,0..maxn] of int64;

Function Power(a,b:longint):int64;
Var     cc:int64;
Begin
        if b=0 then exit(1);
        cc:=power(a,b shr 1);
        power:=(cc*cc) mod base;
        if b and 1=1 then power:=(power*a) mod base;
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(r,c,m,n);
        for i:=1 to r do readln(b[i]);
        for i:=1 to m do readln(a[i]);
        pow[0]:=1; inv[0]:=1;
        modul:=power(2,base-2);
        for i:=1 to m*n do
        begin
                pow[i]:=(pow[i-1]*2) mod base;
                inv[i]:=(inv[i-1]*modul) mod base;
        end;
        sumb:=0;
        for i:=1 to r do
                for j:=1 to c do
                        if b[i,j]='o' then sumb:=(sumb+pow[(i-1)*n+j]) mod base;
        for i:=1 to m do
                for j:=1 to n do
                begin
                        sum[i,j]:=(sum[i-1,j]+sum[i,j-1]-sum[i-1,j-1]) mod base;
                        if a[i,j]='o' then sum[i,j]:=(sum[i,j]+pow[(i-1)*n+j]) mod base;
                end;
End;

Procedure Process;
Var     i,j:longint;
        suma:int64;
Begin
        res:=0;
        for i:=1 to m-r+1 do
                for j:=1 to n-c+1 do
                begin
                        suma:=sum[i+r-1,j+c-1]-sum[i+r-1,j-1]-sum[i-1,j+c-1]+sum[i-1,j-1];
                        suma:=suma*inv[(i-1)*n+j-1];
                        if (suma-sumb) mod base=0 then inc(res);
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
