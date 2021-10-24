Uses    Math;

Const   ginp='bowling.inp';
        gout='bowling.out';
        maxn=200010;
        oo=trunc(1e15);

Type    Quece= record pos:longint; g,d:int64; end;

Var     st,n,d:longint;
        a,f,f2:array[-2*maxn..2*maxn] of int64;
        res:int64;
        l,r:longint;
        q:array[0..maxn] of quece;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,d);
        for i:=1 to n do read(a[i]);
        for i:=1 to 2*n do
        begin
                if i>n then a[i]:=0;
                a[i]:=a[i]+a[i-1];
        end;
        readln;
End;

Procedure Push(i:longint; ff,aa:int64);
Begin
        while (l<=r) and (ff>=q[r].g+q[r].d) do
        begin
                q[r-1].d:=q[r-1].d+q[r].d;
                dec(r);
        end;
        inc(r);
        q[r].pos:=i; q[r].g:=ff; q[r].d:=aa;
End;

Procedure Pop(i:longint);
Begin
        while (l<=r) and (q[l].pos<=i) do inc(l);
End;

Procedure Process;
Var     i:longint;
Begin
        l:=1; r:=0;
        res:=-oo;
        for i:=1 to n do
        begin
                pop(i-2*d-1);
                f[i]:=f2[i-2*d-1]+a[i+d]-a[i-d-1];
                if (l<=r) then f[i]:=max(f[i],f[q[l].pos]-a[q[l].pos+d]+a[i+d]);
                push(i,f[i]-a[i+d]+a[i-d-1],a[i-d]-a[i-d-1]);
                res:=max(res,f[i]);
                f2[i]:=max(f2[i-1],f[i]);
        end;
        writeln(res);
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
