Const   ginp='connection.inp';
        gout='connection.out';
        maxn=1010;

Var     m,n,cr:longint;
        pa:array[0..maxn*maxn] of longint;
        ot:array[0..2*maxn*maxn] of char;
        o:array[0..2*maxn*maxn] of longint;

Function Find(p:longint):longint;
Begin
        while pa[p]<>p do p:=pa[p];
        find:=p;
End;

Procedure Enter;
Var     i,q,x,y,x0,y0:longint;
        typ:string[1];
Begin
        readln(m,n,q);
        for i:=1 to m*n do pa[i]:=i;
        for i:=1 to q do
        begin
                readln(typ,x,y);
                x:=(x-1)*n+y;
                if typ='R' then y:=x+1 else y:=x+n;
                x0:=find(x); y0:=find(y);
                pa[y0]:=x0; pa[x]:=x0; pa[y]:=x0;
        end;
End;

Procedure Process;
Var     i,x,y,x0,y0:longint;
Begin
        cr:=0;
        for x:=1 to m*n do
        begin
                if (x-1) mod n+1<n then
                begin
                        y:=x+1;
                        x0:=find(x); y0:=find(y);
                        if x0<>y0 then
                        begin
                                inc(cr);
                                ot[cr]:='R'; o[cr]:=x;
                        end;
                        pa[y0]:=x0; pa[x]:=x0; pa[y]:=x0;
                end;
                if (x-1) div n+1<m then
                begin
                        y:=x+n;
                        x0:=find(x); y0:=find(y);
                        if x0<>y0 then
                        begin
                                inc(cr);
                                ot[cr]:='D'; o[cr]:=x;
                        end;
                        pa[y0]:=x0; pa[x]:=x0; pa[y]:=x0;
                end;
        end;
        writeln(cr);
        for i:=1 to cr do writeln(ot[i],' ',(o[i]-1) div n+1,' ',(o[i]-1) mod n+1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
