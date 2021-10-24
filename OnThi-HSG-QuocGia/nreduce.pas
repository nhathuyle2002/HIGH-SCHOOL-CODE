Uses    Math;

Const   ginp='nreduce.inp';
        gout='nreduce.out';
        maxn=100001;
        maxm=1000001;

Var     n,m,cou,dem,dem0:longint;
        o:array[0..maxm] of longint;
        c:array[1..3] of longint;
        x,y,pos:array[1..3,0..maxm] of longint;
        h,pa,pa0,h0:array[0..maxn] of longint;

Procedure Enter;
Var     i,u,v,w:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(u,v,w);
                inc(c[w]);
                x[w,c[w]]:=u; y[w,c[w]]:=v; pos[w,c[w]]:=i;
        end;
End;

Function Find(u:longint):longint;
Begin
        while pa[u]<>u do u:=pa[u];
        find:=u;
End;

Procedure Process;
Var     u,x0,y0,i:longint;
Begin
        for u:=1 to n do
        begin
                pa[u]:=u;
                h[u]:=0;
        end;
        cou:=0; dem:=0;
        for i:=1 to c[3] do
        begin
                x0:=find(x[3,i]); y0:=find(y[3,i]);
                if x0<>y0 then inc(dem);
                if x0=y0 then
                begin
                        inc(cou); o[cou]:=pos[3,i];
                        pa[x[3,i]]:=x0; pa[y[3,i]]:=y0;
                end else
                if h[x0]<h[y0] then
                begin
                        pa[x0]:=y0; pa[x[3,i]]:=y0; pa[y[3,i]]:=y0;
                end else
                begin
                        pa[y0]:=x0; pa[x[3,i]]:=x0; pa[y[3,i]]:=x0;
                        h[x0]:=max(h[x0],h[y0]+1);
                end;
        end;
        dem0:=dem;
        for u:=1 to n do
        begin
                pa0[u]:=pa[u];
                h0[u]:=h[u];
        end;
        for i:=1 to c[2] do
        begin
                x0:=find(x[2,i]); y0:=find(y[2,i]);
                if x0<>y0 then inc(dem);
                if x0=y0 then
                begin
                        inc(cou); o[cou]:=pos[2,i];
                        pa[x[2,i]]:=x0; pa[y[2,i]]:=y0;
                end else
                if h[x0]<h[y0] then
                begin
                        pa[x0]:=y0; pa[x[2,i]]:=y0; pa[y[2,i]]:=y0;
                end else
                begin
                        pa[y0]:=x0; pa[x[2,i]]:=x0; pa[y[2,i]]:=x0;
                        h[x0]:=max(h[x0],h[y0]+1);
                end;
        end;
        if dem<n-1 then
        begin
                write(-1);
                exit;
        end;
        dem:=dem0;
        for u:=1 to n do
        begin
                pa[u]:=pa0[u];
                h[u]:=h0[u];
        end;
        for i:=1 to c[1] do
        begin
                x0:=find(x[1,i]); y0:=find(y[1,i]);
                if x0<>y0 then inc(dem);
                if x0=y0 then
                begin
                        inc(cou); o[cou]:=pos[1,i];
                        pa[x[1,i]]:=x0; pa[y[1,i]]:=y0;
                end else
                if h[x0]<h[y0] then
                begin
                        pa[x0]:=y0; pa[x[1,i]]:=y0; pa[y[1,i]]:=y0;
                end else
                begin
                        pa[y0]:=x0; pa[x[1,i]]:=x0; pa[y[1,i]]:=x0;
                        h[x0]:=max(h[x0],h[y0]+1);
                end;
        end;
        if dem<n-1 then
        begin
                write(-1);
                exit;
        end;
        writeln(cou);
        for i:=1 to cou do writeln(o[i]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
