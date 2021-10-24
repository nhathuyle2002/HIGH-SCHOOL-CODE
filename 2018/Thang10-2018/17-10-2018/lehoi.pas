Const   ginp='lehoi.inp';
        gout='lehoi.out';
        maxn=30010;

Type    save= record g,pos:longint; end;
        mang= array[0..maxn] of save;

Var     n,m:longint;
        res:int64;
        a,b:mang;
        c:array[0..maxn] of longint;

Procedure Sorta(l,r:longint);
Var     i,j:longint;
        t,tmp:save;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i].g<t.g do inc(i);
                while a[j].g>t.g do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sorta(l,j); sorta(i,r);
End;

Procedure Sortb(l,r:longint);
Var     i,j:longint;
        t,tmp:save;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i].g<t.g do inc(i);
                while b[j].g>t.g do dec(j);
                if i<=j then
                begin
                        tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sortb(l,j); sortb(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to n do
        begin
                readln(a[i].g);
                a[i].pos:=i;
        end;
        for i:=1 to m do
        begin
                readln(b[i].g);
                b[i].pos:=i;
        end;
        sorta(1,n); sortb(1,m);
End;

Procedure Process;
Var     i:longint;
Begin
        res:=0;
        for i:=1 to n do
        begin
                res:=res+a[i].g*b[n-i+1].g;
                c[a[i].pos]:=b[n-i+1].pos;
        end;
        writeln(res);
        for i:=1 to n do writeln(c[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
