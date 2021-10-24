Const   ginp='wifipass.inp';
        gout='wifipass.out';
        maxn=1000001;
        maxg=1000001;

Var     st,nt:longint;
        n:int64;
        a:array[0..maxn] of longint;
        d:array[0..maxg] of longint;

Procedure Init;
Var     i,j:longint;
Begin
        fillchar(d,sizeof(d),0);
        for i:=2 to maxg do
                if d[i]=0 then
                begin
                        if i<=maxn then
                        begin
                                inc(nt); a[nt]:=i;
                        end;
                        d[i]:=i;
                        for j:=i to maxg div i do
                                if d[i*j]=0 then d[i*j]:=i;
                end;
End;

Procedure Process;
Var     i:longint;
Begin
        readln(n);
        n:=n*n+1;
        {if n<=maxg then
        begin
                writeln(d[n]-1,n div d[n]-1);
        end;}
        for i:=1 to nt do
                if n mod a[i]=0 then break;
        writeln(a[i]-1,n div a[i]-1);
End;

Procedure SinhTest;
Var     i:longint;
Begin
        Assign(output,ginp); Rewrite(output);
        st:=2500;
        writeln(st);
        randomize;
        for i:=1 to st do writeln(random(1000000-100000)+100000);
        Close(output);
End;

Begin
        //SinhTest;
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Init;
        readln(st);
        for st:=1 to st do Process;
        Close(input); Close(output);
End.
