Const   ginp='colflag.inp';
        gout='colflag.out';
        mn=255;

Var     n,m:longint;
        d:array[0..mn] of longint;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(n,m);
        for i:=1 to n do
        begin
                read(x);
                inc(d[x]);
        end;
        readln;
        for i:=1 to m do
        begin
                read(x);
                inc(d[x]);
        end;
End;

Procedure Process;
Var     i,j,tmp:longint;
Begin
        for i:=0 to mn do
                for j:=i+1 to mn do
                        if d[i]<d[j] then
                        begin
                                tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        end;
        tmp:=0;
        for i:=0 to mn do
        begin
                tmp:=tmp+d[i];
                if tmp>=n then break;
        end;
        write(i+1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
