Const   ginp='vector.inp';
        gout='vector.out';
        maxn=10000000;

Var     m,n:longint;
        nt:array[0..maxn] of longint;
        a,b:array[0..maxn] of longint;
        k:longint;
        o:array[0..maxn] of char;
        g:array[0..maxn] of longint;

Procedure Init;
Var     i,j:longint;
Begin
        for i:=2 to maxn do
                if nt[i]=0 then
                begin
                        nt[i]:=i;
                        for j:=i to maxn div i do nt[i*j]:=i;
                end;
End;

Procedure Pta(x:longint);
Begin
        while x>1 do
        begin
                inc(a[nt[x]]);
                x:=x div nt[x];
        end;
End;

Procedure Ptb(x:longint);
Begin
        while x>1 do
        begin
                inc(b[nt[x]]);
                x:=x div nt[x];
        end;
End;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(m);
        for i:=1 to m do
        begin
                read(x);
                pta(x);
        end;
        readln;
        readln(n);
        for i:=1 to n do
        begin
                read(x);
                ptb(x);
        end;
End;

Procedure Process;
Var     p,i:longint;
Begin
        k:=0;
        for p:=2 to maxn do
                if a[p]+b[p]>0 then
                begin
                        if b[p] mod 2=1 then
                        begin
                                inc(k);
                                o[k]:='D'; g[k]:=p;
                                inc(b[p]);
                        end;
                        if (b[p] div 2+a[p]) mod 2=1 then
                        begin
                                inc(k);
                                o[k]:='D'; g[k]:=p;
                                inc(b[p]);
                                inc(k);
                                o[k]:='D'; g[k]:=p;
                                inc(b[p]);
                        end;
                        for i:=1 to b[p] div 2 do
                        begin
                                inc(k);
                                o[k]:='W'; g[k]:=p;
                                //inc(a[p]); dec(b[p],2);
                        end;
                        for i:=1 to (b[p] div 2+a[p]) div 2 do
                        begin
                                inc(k);
                                o[k]:='L'; g[k]:=p;
                                //dec(a[p],2);
                        end;
                end;
        writeln(k);
        for i:=1 to k do writeln(g[i],' ',o[i]);
End;

Procedure Sinh;
Var     i,j:longint;
        Function R(x:longint):longint;
        Begin
                r:=random(x)+1;
        End;
Begin
        Assign(output,ginp); Rewrite(output);
        m:=300;
        writeln(m);
        for i:=1 to m do write(r(800000)+8000000,' ');
        writeln;
        n:=300;
        writeln(n);
        for i:=1 to n do write(r(800000)+8000000,' ');
        Close(output);
End;

Begin
        //Sinh;
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Init;
        Enter;
        Process;
        Close(input); Close(output);
End.
