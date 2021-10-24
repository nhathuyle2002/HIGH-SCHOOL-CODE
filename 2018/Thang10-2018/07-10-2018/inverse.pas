Const   ginp='inverse.inp';
        gout='inverse.out';
        maxn=501;

Var     m,n,res,rr:longint;
        ou,oo:array[0..maxn*2] of longint;
        d,c:array[0..maxn,0..maxn] of longint;

Procedure Enter;
Var     i,j:longint;
        a,b:array[0..maxn] of ansistring;
Begin
        readln(m,n);
        for i:=1 to m do readln(a[i]);
        for i:=1 to m do readln(b[i]);
        for i:=1 to m do
                for j:=1 to n do
                        if a[i,j]<>b[i,j] then
                        begin
                                d[i,j]:=1;
                        end
                        else d[i,j]:=0;
End;

Procedure PP;
Var     i,j,cou:longint;
Begin
        for i:=1 to m do
        if c[i,1]=1 then
        begin
                inc(rr); oo[rr]:=i;
                for j:=1 to n do c[i,j]:=1-c[i,j];
        end;
        for j:=1 to n do
        begin
                cou:=0;
                for i:=1 to m do
                        if c[i,j]=1 then inc(cou);
                if cou=0 then continue else
                if cou=m then
                begin
                        inc(rr); oo[rr]:=-j;
                end
                else exit;
        end;
        if (res=-1) or (res>rr) then
        begin
                res:=rr;
                ou:=oo;
        end;
end;

Procedure Process;
Var     i,j:longint;
Begin
        res:=-1;

        c:=d;
        rr:=0; pp;
        c:=d;
        for i:=1 to m do c[i,1]:=1-d[i,1];
        rr:=1; oo[1]:=-1; pp;

        writeln(res);
        for i:=1 to res do write(ou[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
