Const   ginp='games.inp';
        gout='games.out';

Var     x,y,cr:longint;
        rx,ry,rz:array[0..1000010] of longint;
        a,pos:array[1..5] of longint;

Procedure Enter;
Var     i,j,tmp:longint;
Begin
        read(x,y);
        for i:=1 to 5 do
        begin
                read(a[i]);
                pos[i]:=i;
        end;
        for i:=1 to 5 do
                for j:=i+1 to 5 do
                if a[i]<a[j] then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        tmp:=pos[i]; pos[i]:=pos[j]; pos[j]:=tmp;
                end;
End;

Procedure Process;
Var     i,sum,tmp:longint;
        c:array[0..3] of longint;
Begin
        sum:=0; c[0]:=0;
        for i:=1 to 5 do
        begin
                sum:=sum+a[i];
                if a[i]=1 then inc(c[0]);
        end;
        if sum<=3 then
        begin
                if c[0]<3 then exit;
                c[0]:=0;
                for i:=1 to 5 do
                        if a[i]=1 then
                        begin
                                inc(c[0]);
                                c[c[0]]:=i;
                        end;
                writeln(1);
                write(c[1],' ',c[2],' ',c[3]);
                exit;
        end;
        cr:=0;
        for i:=5 downto 3 do
                while a[i]>0 do
                begin
                        dec(a[i]); dec(a[i-1]);
                        inc(cr);
                        rx[cr]:=pos[i]; ry[cr]:=pos[i-1]; rz[cr]:=pos[1];
                end;
        while a[2]>=3 do
        begin
                inc(cr); rx[cr]:=pos[1]; ry[cr]:=pos[2]; rz[cr]:=pos[3];
                inc(cr); rx[cr]:=pos[2]; ry[cr]:=pos[3]; rz[cr]:=pos[1];
                inc(cr); rx[cr]:=pos[2]; ry[cr]:=pos[3]; rz[cr]:=pos[1];
                a[2]:=a[2]-3;
        end;
        if a[2]=1 then
        begin
                inc(cr); rx[cr]:=pos[1]; ry[cr]:=pos[2]; rz[cr]:=pos[3];
                tmp:=pos[2]; pos[2]:=pos[3]; pos[3]:=tmp;
                a[2]:=2;
        end;
        if a[2]=2 then
        begin
                inc(cr); rx[cr]:=pos[1]; ry[cr]:=pos[2]; rz[cr]:=pos[3];
                inc(cr); rx[cr]:=pos[1]; ry[cr]:=pos[3]; rz[cr]:=pos[4];
                inc(cr); rx[cr]:=pos[3]; ry[cr]:=pos[4]; rz[cr]:=pos[1];
                inc(cr); rx[cr]:=pos[2]; ry[cr]:=pos[4]; rz[cr]:=pos[1];
        end;
        writeln(cr);
        for i:=1 to cr do writeln(rx[i],' ',ry[i],' ',rz[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
