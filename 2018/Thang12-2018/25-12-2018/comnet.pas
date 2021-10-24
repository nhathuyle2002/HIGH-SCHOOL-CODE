Uses    Math;

Const   ginp='comnet.inp';
        gout='comnet.out';
        maxn=300001;

Type    edge= record x,y,link,w:longint; end;

Var     n,m,mw:longint;
        e:array[0..maxn] of edge;
        head,d:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to m do
        with e[i] do
        begin
                readln(x,y);
                w:=i;
                link:=head[x];
                head[x]:=i;
        end;
End;

Procedure Dfs(u:longint);
Var     i:longint;
Begin
        d[u]:=1;
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if (w<=mw) and (d[y]=0) then dfs(y);
                i:=link;
        end;
End;

Procedure Process;
Var     l,r,i:longint;
Begin
        l:=1; r:=m+1;
        while l<r do
        begin
                mw:=(l+r) shr 1;
                for i:=1 to n do d[i]:=0;
                dfs(1);
                if d[n]=1 then r:=mw else l:=mw+1;
        end;
        if l=m+1 then write(-1) else write(l);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
