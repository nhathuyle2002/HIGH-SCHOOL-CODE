Const   ginp='lock.inp';
        gout='lock.out';
        maxn=1000010;

Var     n,x,y:longint;
        a:ansistring;
        pos:array[1..4,0..maxn] of longint;

Procedure Enter;
Begin
        readln(n);
        readln(a);
        read(x,y);
End;

Procedure Process;
Var     i:longint;
Begin
        for i:=1 to n do
                if a[i]='L' then
                begin
                        inc(pos[1,0]);
                        pos[1,pos[1,0]]:=i;
                end else
                if a[i]='U' then
                begin
                        inc(pos[2,0]);
                        pos[2,pos[2,0]]:=i;
                end else
                if a[i]='R' then
                begin
                        inc(pos[3,0]);
                        pos[3,pos[3,0]]:=i;
                end else
                begin
                        inc(pos[4,0]);
                        pos[4,pos[4,0]]:=i;
                end;
End;

Procedure Answer;
Begin
        if (x<0) and (y<0) and (pos[1,0]>=-x) and (pos[4,0]>=-y)
                then write(pos[1,-x],' ',0,' ',0,' ',pos[4,-y]) else
        if (x<0) and (y>0) and (pos[1,0]>=-x) and (pos[2,0]>=y)
                then write(pos[1,-x],' ',pos[2,y],' ',0,' ',0) else
        if (x>0) and (y<0) and (pos[3,0]>=x) and (pos[4,0]>=-y)
                then write(0,' ',0,' ',pos[3,x],' ',pos[4,-y]) else
        if (x>0) and (y>0) and (pos[3,0]>=x) and (pos[2,0]>=y)
                then write(0,' ',pos[2,y],' ',pos[3,x],' ',0) else
        write(-1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Answer;
        Close(input); Close(output);
End.
