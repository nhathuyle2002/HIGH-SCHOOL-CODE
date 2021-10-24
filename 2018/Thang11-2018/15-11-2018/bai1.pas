Const   ginp='bai1.inp';
        gout='bai1.out';
        maxn=1001;

Var     n,l:longint;
        a,b:array[0..maxn] of longint;
        d:array[0..maxn] of boolean;
        r1,r2,cr1,cr2:longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(l);
        readln(n);
        for i:=1 to n do readln(a[i],b[i]);
End;

Procedure Process;
Var     i,cou,j:longint;
Begin
        r1:=0; cr1:=0; r2:=0; cr2:=0;
        fillchar(d,sizeof(d),true);
        for i:=1 to n do
        begin
                if cr1<b[i]-a[i]+1 then
                begin
                        r1:=i; cr1:=b[i]-a[i]+1;
                end;
                cou:=0;
                for j:=a[i] to b[i] do
                        if d[j] then
                        begin
                                inc(cou);
                                d[j]:=false;
                        end;
                if cr2<cou then
                begin
                        r2:=i; cr2:=cou;
                end;
        end;
        writeln(r1); write(r2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
