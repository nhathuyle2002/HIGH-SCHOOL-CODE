Const   ginp='concomp.inp';
        gout='concomp.out';
        maxn=2001;
        maxm=30001;

Type    edge= record x,y:longint; end;

Var     n,m,q:longint;
        a:array[0..maxm] of edge;
        pb,pc:array[0..maxm] of longint;
        b,c:array[0..maxn] of edge;
        f:array[0..maxn,0..maxn] of longint;
        pa:array[0..maxn] of longint;

Function Find(u:longint):longint;
Begin
        while u<>pa[u] do u:=pa[u];
        find:=u;
End;

Procedure Enter;
Var     i,u,cou,x0,y0:longint;
Begin
        readln(n,m);
        for i:=1 to m do readln(a[i].x,a[i].y);
        cou:=0;
        for u:=1 to n do pa[u]:=u;
        pb[0]:=0;
        for i:=1 to m do
        with a[i] do
        begin
                x0:=find(x); y0:=find(y);
                if x0<>y0 then
                begin
                        inc(cou); b[cou]:=a[i];
                end;
                pa[x]:=x0; pa[y]:=x0; pa[y0]:=x0;
                pb[i]:=cou;
        end;
        cou:=n;
        for u:=1 to n do pa[u]:=u;
        pc[m+1]:=n;
        for i:=m downto 1 do
        with a[i] do
        begin
                x0:=find(x); y0:=find(y);
                if x0<>y0 then
                begin
                        dec(cou); c[cou]:=a[i];
                end;
                pa[x]:=x0; pa[y]:=x0; pa[y0]:=x0;
                pc[i]:=cou;
        end;
End;

Procedure Init;
Var     i,j,u,x0,y0,cou:longint;
Begin
        for i:=0 to pb[m] do
        begin
                for u:=1 to n do pa[u]:=u;
                cou:=n;
                for j:=1 to i do
                with b[j] do
                begin
                        x0:=find(x); y0:=find(y);
                        if x0<>y0 then dec(cou);
                        pa[x]:=x0; pa[y]:=x0; pa[y0]:=x0;
                end;
                f[i,n]:=cou;
                for j:=n-1 downto pc[1] do
                with c[j] do
                begin
                        x0:=find(x); y0:=find(y);
                        if x0<>y0 then dec(cou);
                        pa[x]:=x0; pa[y]:=x0; pa[y0]:=x0;
                        f[i,j]:=cou;
                end;
        end;
End;

Procedure Process;
Var     i,l,r:longint;
Begin
        readln(q);
        for i:=1 to q do
        begin
                readln(l,r);
                writeln(f[pb[l-1],pc[r+1]]);
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        Process;
        Close(input); Close(output);
End.
