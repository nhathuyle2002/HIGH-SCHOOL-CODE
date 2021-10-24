Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';

Var     n:longint;
        s:ansistring;
        d:array['A'..'z'] of longint;

Procedure Enter;
Begin
        readln(n);
        read(s);
End;

Procedure Process;
Var     i,j,gmax:longint;
Begin
        for i:=1 to n do
        begin
                fillchar(d,sizeof(d),0);
                gmax:=0;
                for j:=i to n do
                begin
                        inc(d[s[j]]);
                        gmax:=max(gmax,d[s[j]]);
                        if gmax<=(j-i+1) div 2 then
                        begin
                                writeln('YES');
                                write(copy(s,i,j-i+1));
                                exit;
                        end;
                end;
        end;
        write('NO');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
