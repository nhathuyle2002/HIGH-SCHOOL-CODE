Const   ginp='matrix.inp';
        gout='matrix.out';

Var     m,n,res,msr,mbit:longint;
        a:array[0..21,0..21] of longint;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
        mbit:=1 shl m -1;
End;

Function Getb(x,i:longint):longint;
Begin
        getb:=x shr (i-1) and 1;
End;

Procedure Process;
Var     x,i,j,cou:longint;
        d,c:array[0..21] of longint;
Begin
        res:=0; msr:=0;
        for x:=1 to mbit do
        begin
                cou:=0;
                for j:=1 to n do d[j]:=0;
                for i:=1 to m do
                        if getb(x,i)=1 then
                        begin
                                for j:=1 to n do d[j]:=d[j]+a[i,j];
                                inc(cou); c[cou]:=i;
                        end;
                if cou<=res then continue;
                j:=0;
                for i:=1 to cou do
                begin
                        inc(j);
                        while (j<=n) and ((d[j]>1) or (a[c[i],j]=0)) do inc(j);
                        if j>n then break;
                end;
                if j<=n then
                begin
                        res:=cou; msr:=x;
                end;
        end;
End;

Procedure Answer;
Var     i,j,cou,co:longint;
        d,c,ou:array[0..21] of longint;
Begin
        writeln(res);
        if res=0 then
                for i:=1 to m do write(i,' ')
        else begin
                cou:=0;
                for j:=1 to n do d[j]:=0;
                for i:=1 to m do
                        if getb(msr,i)=1 then
                        begin
                                inc(cou); c[cou]:=i;
                                for j:=1 to n do d[j]:=d[j]+a[i,j];
                        end
                        else write(i,' ');
                j:=0; co:=0;
                for i:=1 to cou do
                begin
                        inc(j);
                        while (j<=n) and ((d[j]>1) or (a[c[i],j]=0)) do
                        begin
                                inc(co); ou[co]:=j;
                                inc(j);
                        end;
                end;
                for j:=j+1 to n do
                begin
                        inc(co); ou[co]:=j;
                end;
                writeln;
                for j:=1 to co do write(ou[j],' ');
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Answer;
        Close(input); Close(output);
End.
