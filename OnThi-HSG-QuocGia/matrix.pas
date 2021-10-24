Const   ginp='matrix.inp';
        gout='matrix.out';
        maxn=501;

Var     m,n,x0,y0:longint;
        a:array[0..maxn,0..maxn] of longint;
        b,pos,posi,posj:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i]>t do inc(i);
                while b[j]<t do dec(j);
                if i<=j then
                begin
                        tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
                        tmp:=pos[i]; pos[i]:=pos[j]; pos[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        if a[i,j]=m*n then
                        begin
                                x0:=i; y0:=j;
                        end;
                end;
                readln;
        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        for i:=1 to m do
        begin
                b[i]:=a[i,y0];
                pos[i]:=i;
        end;
        sort(1,m);
        for i:=1 to m do posi[i]:=pos[i];
        for j:=1 to n do
        begin
                b[j]:=a[x0,j];
                pos[j]:=j;
        end;
        sort(1,n);
        for j:=1 to n do posj[j]:=pos[j];
        for i:=1 to m do
        begin
                for j:=1 to n do write(a[posi[i],posj[j]],' ');
                writeln;
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
