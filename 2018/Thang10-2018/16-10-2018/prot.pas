Uses    Math;

Const   ginp='prot.inp';
        gout='prot.out';
        mn=200;
        base=trunc(1e9);
        maxn=101;

Type    bignum= array[0..mn] of int64;

Var     n,m,l,k:longint;
        res:bignum;
        f:array[0..maxn,0..maxn] of bignum;

Function Cmp(a,b:bignum):boolean;
Var     i:longint;
Begin
        if a[0]<>b[0] then exit(a[0]<b[0]);
        for i:=a[0] downto 1 do
                if a[i]<>b[i] then exit(a[i]<b[i]);
        exit(true);
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
                if c[i]>=base then
                begin
                        nho:=1;
                        c[i]:=c[i]-base;
                end
                else    nho:=0;
        end;
        if nho>0 then
        begin
                inc(c[0]);
                c[c[0]]:=nho;
        end;
End;

Function Setb(x:longint):bignum;
Begin
        setb[0]:=0;
        while x>0 do
        begin
                inc(setb[0]);
                setb[setb[0]]:=x mod base;
                x:=x div base;
        end;
End;

Operator * (a,b:bignum) c:bignum;
Var     i,j:longint;
        nho:int64;
Begin
        c[0]:=a[0]+b[0];
        for i:=1 to c[0] do c[i]:=0;
        nho:=0;
        for i:=1 to a[0] do
        begin
                for j:=1 to b[0] do
                begin
                        c[i+j-1]:=c[i+j-1]+a[i]*b[j]+nho;
                        nho:=c[i+j-1] div base;
                        c[i+j-1]:=c[i+j-1] mod base;
                end;
                while nho>0 do
                begin
                        inc(j);
                        c[i+j-1]:=c[i+j-1]+nho;
                        nho:=c[i+j-1] div base;
                        c[i+j-1]:=c[i+j-1] mod base;
                end;
        end;
        if c[c[0]]=0 then dec(c[0]);
End;

Function Power(a,b:longint):bignum;
Var     c:bignum;
Begin
        if b=0 then exit(setb(1));
        c:=power(a,b shr 1);
        power:=c*c;
        if b and 1=1 then power:=power*setb(a);
End;

Procedure Enter;
Begin
        readln(k,n,m,l);
End;

Procedure WOp(x:bignum);
Var     i:longint;
        c:string[10];
Begin
        write(x[x[0]]);
        for i:=x[0]-1 downto 1 do
        begin
                str(x[i],c);
                while length(c)<9 do c:='0'+c;
                write(c);
        end;
        write(' ');
End;

Procedure Process;
Var     i,j,le,ri,mid:longint;
        c:bignum;
Begin
        f[1,1]:=setb(k);
        f[1,0]:=f[1,1];
        for i:=2 to m do
        begin
                f[i,1]:=f[i-1,0]*setb(k-1);
                f[i,0]:=f[i,1];
                for j:=2 to min(l-1,i) do
                begin
                        f[i,j]:=f[i-1,j-1];
                        f[i,0]:=f[i,0]+f[i,j];
                end;
        end;
        wop(f[m,0]);
        res:=setb(1);
        for i:=1 to n div m do res:=res*f[m,0];
        le:=0; ri:=3500;
        while le<ri do
        begin
                mid:=(le+ri) shr 1;
                c:=power(2,mid);
                if cmp(c,res) then le:=mid+1 else ri:=mid;
        end;
        write(le-1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
