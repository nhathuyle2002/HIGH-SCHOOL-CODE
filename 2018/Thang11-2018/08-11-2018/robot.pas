Const   ginp='robot.inp';
        gout='robot.out';
        maxn=100010;
        oo=trunc(1e6);

Var     n,m:longint;
        a:ansistring;
        x,y:array[0..maxn] of longint;
        sx,sy:array[0..maxn] of int64;

Procedure Sort(l,r:longint; var d:array of longint);
Var     i,j,t,tmp:longint;
Begin
        if l>=r then exit;
        i:=l; j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while t<d[j] do dec(j);
                if i<=j then
                begin
                        tmp:=d[i]; d[i]:=d[j]; d[j]:=tmp;
                        inc(i); dec(j);
                end;
        until i>j;
        sort(l,j,d); sort(i,r,d);
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to n do readln(x[i],y[i]);
        sort(1,n,x); sort(1,n,y);
        x[0]:=-oo; y[0]:=-oo;
        x[n+1]:=oo; y[n+1]:=oo;
        sx[0]:=0; sy[0]:=0;
        for i:=1 to n do
        begin
                sx[i]:=sx[i-1]+x[i];
                sy[i]:=sy[i-1]+y[i];
        end;
        read(a);
End;

Procedure Process;
Var     i,p1,p2:longint;
        resx,resy,x0,y0:int64;
Begin
        x0:=0; y0:=0;
        p1:=0; p2:=0;
        for i:=1 to m do
        begin
                if a[i]='E' then inc(x0) else
                if a[i]='W' then dec(x0) else
                if a[i]='N' then inc(y0) else
                if a[i]='S' then dec(y0);
                while x[p1+1]<x0 do inc(p1);
                while x[p1]>=x0 do dec(p1);
                while y[p2+1]<y0 do inc(p2);
                while y[p2]>=y0 do dec(p2);
                resx:=sx[n]-2*sx[p1]+2*x0*p1-x0*n;
                resy:=sy[n]-2*sy[p2]+2*y0*p2-y0*n;
                writeln(resx+resy);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
