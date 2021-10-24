Const   ginp='roberval3.inp';
        gout='roberval3.out';

Var     w,s1,s2:int64;
        f1,f2,m3:array[0..38] of int64;

Procedure Enter;
Var     i:longint;
Begin
        m3[0]:=1;
        for i:=1 to 38 do m3[i]:=m3[i-1]*3;
        readln(w); s1:=w;
End;

Procedure Process;
Var     i,c:longint;
Begin
        for i:=38 downto 0 do
        begin
                f1[i]:=w div m3[i];
                w:=w mod m3[i];
        end;
        c:=0;
        for i:=0 to 38 do
        begin
                if f1[i] div 3>0 then f1[i+1]:=f1[i+1]+f1[i] div 3;
                f1[i]:=f1[i] mod 3;
                if f1[i]=2 then
                begin
                        f1[i]:=0; inc(f1[i+1]);
                        f2[i]:=1; inc(c);
                end;
        end;
        if c=0 then write(-1) else
        for i:=0 to 38 do
                if f2[i]>0 then
                begin
                        write(i,' ');
                        s1:=s1+m3[i];
                end;
        writeln;
        s2:=0;
        for i:=0 to 38 do
                if f1[i]>0 then
                begin
                        write(i,' ');
                        s2:=s2+m3[i];
                end;
        //writeln;
        //writeln(s1+w); writeln(s2);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
