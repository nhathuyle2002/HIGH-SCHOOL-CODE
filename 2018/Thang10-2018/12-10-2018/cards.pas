Const   ginp='cards2.inp';
        gout='cards.out';
        maxn=100010;

Type    save= record x,y,num:longint; end;

Var     n,m,k:longint;
        a:array[0..maxn] of save;

Function Try(i,pos:longint):longint;
Begin
        if i=0 then exit(pos);
        with a[i] do
        if (x<=pos) and (pos<=x+num-1) then pos:=pos+y-x else
        if (pos<x) and (pos>=y) then pos:=pos+num else
        if (pos>x+num-1) then
        begin
                pos:=pos-num;
                if pos>=y then pos:=pos+num;
        end;
        try:=try(i-1,pos);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,k,m);
        for i:=1 to m do readln(a[i].y,a[i].num,a[i].x);
End;

Procedure Process;
Var     i:longint;
Begin
        for i:=1 to k do
                write(try(m,i),' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
