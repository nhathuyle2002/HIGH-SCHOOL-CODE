Uses    Math;

Const   ginp='cwords.inp';
        gout='cwords.out';
        base=1000000000;

Type    bignum= array[0..5] of int64;

Var     n:longint;
        ok:boolean;
        res,sum:bignum;
        d,c:array['A'..'Z','A'..'Z'] of longint;

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


Procedure Enter;
Var     i:longint;
        a:string;
Begin
        ok:=true;
        readln(n);
        for i:=1 to n do
        begin
                readln(a);
                if length(a)=1 then ok:=false;
                inc(d[a[1],a[length(a)]]);
        end;
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
Var     i:longint;
        x,y,z,t:char;
Begin
        if not ok then
        begin
                write(n);
                exit;
        end;
        res:=ch(0);
        for x:='A' to 'Z' do
        for y:='A' to 'Z' do
        for z:='A' to 'Z' do
        for t:='A' to 'Z' do
        begin
                inc(c[x,y]); inc(c[y,z]); inc(c[t,z]); inc(c[x,t]);
                sum:=ch(1);
                for i:=1 to c[x,y] do sum:=nhan(sum,ch(d[x,y]-i+1)); c[x,y]:=0;
                for i:=1 to c[y,z] do sum:=nhan(sum,ch(d[y,z]-i+1)); c[y,z]:=0;
                for i:=1 to c[t,z] do sum:=nhan(sum,ch(d[t,z]-i+1)); c[t,z]:=0;
                for i:=1 to c[x,t] do sum:=nhan(sum,ch(d[x,t]-i+1)); c[x,t]:=0;
                res:=cong(res,sum);
        end;
        writeOp(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
