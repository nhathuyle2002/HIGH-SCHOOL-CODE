Const   ginp='drawer.inp';
        gout='drawer.out';
        maxn=300010;

Var     n,m:longint;
        root:array[0..maxn] of longint;

Function F_root(u:longint):longint;
Begin
        while root[u]<>u do u:=root[u];
        f_root:=u;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(m,n);
        for i:=0 to n do root[i]:=i;
End;

Procedure Process;
Var     i,x,y,x0,y0:longint;
Begin
        for i:=1 to m do
        begin
                readln(x,y);
                x0:=f_root(x); y0:=f_root(y);
                if (x0=0) and (y0=0) then writeln('SMECE') else
                begin
                        writeln('LADICA');
                        if x0=y0 then
                        begin
                                root[x0]:=0; //root[y0]:=0;
                                root[x]:=0; //root[y]:=0;
                        end else
                        if x0=x then
                        begin
                                root[x0]:=y0; //root[x]:=y0;
                                root[y]:=y0;
                        end else
                        if y0=y then
                        begin
                                root[y0]:=x0; //root[y]:=x0;
                                root[x]:=x0;
                        end else
                        if x0<>0 then
                        begin
                                root[x0]:=y0;
                                root[x]:=y0; root[y]:=y0;
                        end else
                        if y0<>0 then
                        begin
                                root[y0]:=x0;
                                root[y]:=x0; root[x]:=x0;
                        end;
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
