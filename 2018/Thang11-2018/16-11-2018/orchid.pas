Uses    Math;

Const   ginp='orchid.inp';
        gout='orchid.out';
        maxn=100010;

Type    edge= record y,link,w:longint; end;
        save= record g,p:longint; end;

Var     n:longint;
        e:array[-maxn..maxn] of edge;
        f:array[0..maxn,1..2] of save;
        head,res:array[0..maxn] of longint;
        d:array[0..maxn] of boolean;

Procedure Add(i,u,v,c:longint);
Begin
        with e[i] do
        begin
                y:=v; w:=c;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Enter;
Var     i,u,v,c:longint;
Begin
        readln(n);
        for i:=1 to n-1 do
        begin
                readln(u,v,c);
                add(i,u,v,c);
                add(-i,v,u,c);
        end;
End;

Procedure Dfs1(u:longint);
Var     i:longint;
Begin
        d[u]:=false;
        fillchar(f[u],sizeof(f[u]),0);
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if d[y] then
                begin
                        dfs1(y);
                        if f[y,1].g+w>=f[u,1].g then
                        begin
                                f[u,2]:=f[u,1];
                                f[u,1].g:=f[y,1].g+w; f[u,1].p:=y;
                        end else
                        if f[y,1].g+w>f[u,2].g then
                        begin
                                f[u,2].g:=f[y,1].g+w; f[u,2].p:=y;
                        end;
                end;
                i:=link;
        end;
End;

Procedure Dfs2(u,maxl:longint);
Var     i:longint;
Begin
        d[u]:=false;
        res[u]:=max(maxl,f[u,1].g);
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if d[y] then
                begin
                        if y<>f[u,1].p then dfs2(y,max(maxl,f[u,1].g)+w) else
                        dfs2(y,max(maxl,f[u,2].g)+w);
                end;
                i:=link;
        end;
End;

Procedure Process;
Var     u:longint;
Begin
        for u:=1 to n do d[u]:=true;
        dfs1(1);
        for u:=1 to n do d[u]:=true;
        dfs2(1,0);
        for u:=1 to n do write(res[u],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
