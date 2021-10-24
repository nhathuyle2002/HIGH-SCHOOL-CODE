Const   ginp='ss.inp';
        gout='ss.out';

Var     n,m:longint;
        d:array[0..101,0..201] of longint;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(u,v);
                inc(d[u,0]); d[u,d[u,0]]:=i;
                inc(d[v,0]); d[v,d[v,0]]:=i;
        end;
End;

Procedure Process;
Var     i,j,cou:longint;
Begin
        cou:=0;
        for i:=1 to n do
        begin
                if d[i,0]=0 then
                begin
                        writeln(1);
                        inc(cou);
                        writeln(i,' ',m+cou);
                end else
                begin
                        writeln(d[i,0]);
                        for j:=1 to d[i,0] do writeln(i,' ',d[i,j]);
                end;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
