Uses    Math;

Const   ginp='rep.inp';
        gout='rep.out';
        maxn=100001;
        oo=trunc(1e7);

Var     n,res:longint;
        a,b,o:array[0..maxn] of longint;

Procedure Sort(l,r:longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i]<t do inc(i);
                while b[j]>t do dec(j);
                if i<=j then
                begin
                        tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
                        tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j); sort(i,r);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(a[i],b[i]);
        sort(1,n);
End;

Procedure Process;
Var     i,p1,p2:longint;
Begin
        res:=0;
        p1:=-oo; p2:=-oo;
        for i:=1 to n do
                while a[i]>p1 do
                begin
                        inc(res);
                        if p2=b[i] then
                        begin
                                p1:=b[i]-1;
                                o[res]:=p1;
                        end else
                        begin
                                p1:=p2; p2:=b[i];
                                o[res]:=p2;
                        end;
                end;
        writeln(res);
        for i:=1 to res do write(o[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
