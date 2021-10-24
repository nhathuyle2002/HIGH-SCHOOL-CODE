Uses    Math;

Const   ginp='rolling.inp';
        gout='rolling.out';
        tang= 12*14*4;
        base=1000000000;

Type    Xucxac= array[1..6] of longint;
        bignum= array[0..5] of int64;

Var     mn:int64;
        res:bignum;
        sum:array[0..96] of int64;

Function Ch(x:int64):bignum;
Begin
        ch[0]:=0;
        while x>0 do
        begin
                inc(ch[0]);
                ch[ch[0]]:=x mod base;
                x:=x div base;
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

Function Nhan(a,b:bignum):bignum;
Var     i,j,nho:longint;
Begin
        nhan[0]:=a[0]+b[0];
        for i:=1 to nhan[0] do nhan[i]:=0;
        for i:=1 to a[0] do
                for j:=1 to b[0] do
                        inc(nhan[i+j-1],a[i]*b[j]);
        nho:=0;
        for i:=1 to nhan[0] do
        begin
                nhan[i]:=nhan[i]+nho;
                nho:=nhan[i] div base;
                nhan[i]:=nhan[i] mod base;
        end;
        while (nhan[0]>0) and (nhan[nhan[0]]=0) do dec(nhan[0]);
End;

Procedure R(var a:xucxac);
Var     tmp:longint;
Begin
        tmp:=a[6];
        a[6]:=a[5]; a[5]:=a[1]; a[1]:=a[2]; a[2]:=tmp;
End;

Procedure L(var a:xucxac);
Var     tmp:longint;
Begin
        tmp:=a[6];
        a[6]:=a[2]; a[2]:=a[1]; a[1]:=a[5]; a[5]:=tmp;
End;

Procedure U(var a:xucxac);
Var     tmp:longint;
Begin
        tmp:=a[6];
        a[6]:=a[3]; a[3]:=a[1]; a[1]:=a[4]; a[4]:=tmp;
End;

Procedure D(var a:xucxac);
Var     tmp:longint;
Begin
        tmp:=a[6];
        a[6]:=a[4]; a[4]:=a[1]; a[1]:=a[3]; a[3]:=tmp;
End;

Procedure Create(n:longint);
Var     i:longint;
        a:xucxac;
Begin
        for i:=1 to 6 do a[i]:=i; L(a);
        fillchar(sum,sizeof(sum),0);
        repeat
                for i:=1 to n do
                begin
                        R(a); sum[n]:=sum[n]+a[6];
                end;
                for i:=1 to n-1 do
                begin
                        D(a); sum[n]:=sum[n]+a[6];
                end;
                for i:=1 to n-1 do
                begin
                        L(a); sum[n]:=sum[n]+a[6];
                end;
                for i:=1 to n-2 do
                begin
                        U(a); sum[n]:=sum[n]+a[6];
                end;
                n:=n-2;
        until n<=0;
End;

Procedure WriteOP(x:bignum);
Var     i:longint;
        s:string[20];
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
Var     i,n:longint;
        k:int64;
Begin
        readln(mn);
        create(mn mod 48+48);
        res:=ch(0);
        if mn mod 2=0 then n:=2 else
        begin
                n:=3;
                res:=ch(sum[1]);
        end;
        i:=0;
        while (i<48) and (n+i<=mn) do
        begin
                k:=(mn-n-i) div 48+1;
                res:=cong(res,cong(nhan(ch(sum[n+i]),ch(k)),nhan(nhan(ch(k-1),ch(k)),ch(tang div 2))));
                i:=i+2;
        end;
        writeop(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        while not seekeof(input) do Process;
        Close(input); Close(output);
End.
