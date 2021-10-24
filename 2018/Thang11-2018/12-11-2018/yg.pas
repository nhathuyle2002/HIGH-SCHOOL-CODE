Uses    Math;

Const   ginp='yg.inp';
        gout='yg.out';
        maxn=100010;
        maxm=200010;

Var     n,m,k:longint;
        x,y:array[0..maxm] of longint;
        pa,f,h:array[0..maxn] of longint;

Function Find(p:longint):longint;
Begin
        while pa[p]<>p do p:=pa[p];
        find:=p;
End;

Function Add(x0,y0,x,y:longint):longint;
Begin
        if x0=y0 then
        begin
                pa[x]:=x0; pa[y]:=y0;
                exit(f[x0]);
        end;
        if h[x0]>h[y0] then
        begin
                pa[y0]:=x0; pa[x]:=x0; pa[y]:=x0;
                h[x0]:=max(h[x0],h[y0]+1);
                f[x0]:=f[x0]+f[y0];
                exit(f[x0]);
        end else
        begin
                pa[x0]:=y0; pa[x]:=y0; pa[y]:=y0;
                h[y0]:=max(h[y0],h[x0]+1);
                f[y0]:=f[y0]+f[x0];
                exit(f[y0]);
        end;
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m,k);
        for i:=1 to m do readln(x[i],y[i]);
End;

Procedure Process1;
Var     i,x0,y0:longint;
Begin
        for i:=1 to n do
        begin
                pa[i]:=i;
                if i<=k then f[i]:=1 else f[i]:=0;
                h[i]:=1;
        end;
        for i:=1 to m+1 do
        begin
                if i=m+1 then break;
                x0:=find(x[i]); y0:=find(y[i]);
                if add(x0,y0,x[i],y[i])=k then break;
        end;
        if i=m+1 then write(0,' ') else write(i,' ');
End;

Procedure Process2;
Var     i,x0,y0:longint;
Begin
        for i:=1 to n do
        begin
                pa[i]:=i;
                if i>k then f[i]:=1 else f[i]:=0;
                h[i]:=1;
        end;
        for i:=1 to m+1 do
        begin
                if i=m+1 then break;
                x0:=find(x[i]); y0:=find(y[i]);
                if add(x0,y0,x[i],y[i])=n-k then break;
        end;
        if i=m+1 then write(0,' ') else write(i,' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process1;
        Process2;
        Close(input); Close(output);
End.
