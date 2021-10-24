Const   ginp='puzzle.inp';
        gout='puzzle.out';

Var     st:longint;
        w0,h0,w1,h1,w,h,d:array[1..4] of longint;
        ok:boolean;

Procedure Enter;
Var     i:longint;
Begin
        for i:=1 to 4 do read(w0[i],h0[i]);
        readln;
End;

Procedure Init(x:longint);
Var     i:longint;
Begin
        for i:=1 to 4 do
                if x shr (i-1) and 1=1 then
                begin
                        w1[i]:=h0[i];
                        h1[i]:=w0[i];
                end else
                begin
                        w1[i]:=w0[i];
                        h1[i]:=h0[i];
                end;
        for i:=1 to 4 do d[i]:=0;
End;

Function Check:boolean;
Begin
        check:=false;
        if (h[1]=h[2]) and (h[2]=h[3]) and (h[3]=h[4]) then exit(true);
        if (w[1]=w[2]) then
        begin
                if (w[3]=w[4]) and (h[1]+h[2]=h[3]+h[4]) then exit(true);
                if (h[3]=h[1]+h[2]) and (h[4]=h[3]) then exit(true);
        end;
        if (w[1]<w[2]) and (h[1]=h[3]) then
        begin
                if (h[4]=h[3]) and (w[1]+w[3]+w[4]=w[2]) then exit(true);
                if (h[4]=h[1]+h[2]) and (w[1]+w[3]=w[2]) then exit(true);
                if (h[4]=h[2]) and (w[1]+w[3]=w[2]+w[4]) then exit(true);
        end;
End;

Procedure Try(i:longint);
Var     j:longint;
Begin
        if ok then exit;
        if i=5 then
        begin
                if check then ok:=true;
                exit;
        end;
        for j:=1 to 4 do
                if d[j]=0 then
                begin
                        d[j]:=1;
                        w[i]:=w1[j]; h[i]:=h1[j];
                        try(i+1);
                        d[j]:=0;
                end;
End;

Procedure Process;
Var     i:longint;
Begin
        ok:=false;
        for i:=0 to 15 do
        begin
                Init(i);
                try(1);
        end;
        if ok then writeln('YES') else writeln('NO');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                Process;
        end;
        Close(input); Close(output);
End.
