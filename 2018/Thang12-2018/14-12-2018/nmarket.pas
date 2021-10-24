Const   ginp='nmarket.inp';
        gout='nmarket.out';
        maxn=1000010;

Type    edge= record y,link:longint; end;

Var     n,m,k:longint;
        s,head:array[0..maxn] of longint;
        e:array[0..maxn] of edge;
        d:array[0..maxn] of longint;
        l,r:longint;
        q:array[0..maxn] of longint;

Procedure Add(i,u,v:longint);
Begin
        with e[i] do
        begin
                y:=v;
                link:=head[u];
        end;
        head[u]:=i;
End;

Procedure Enter;
Var     i,u,v:longint;
Begin
        readln(n,m,k);
        for i:=1 to k do read(s[i]); readln;
        for i:=1 to m do
        begin
                readln(u,v);
                add(i,v,u);
        end;
End;

Procedure Update(u,x:longint);
Begin
        if d[u]>-1 then exit;
        d[u]:=x;
        inc(r); q[r]:=u;
End;

Function Pop:longint;
Begin
        pop:=q[l];
        inc(l);
End;

Procedure Process;
Var     u,i:longint;
Begin
        for u:=1 to n do d[u]:=-1;
        l:=1; r:=0;
        for i:=1 to k do update(s[i],0);
        repeat
                if l>r then break;
                u:=pop;
                i:=head[u];
                while i<>0 do
                with e[i] do
                begin
                        update(y,d[u]+1);
                        i:=link;
                end;
        until false;
        for u:=1 to n do writeln(d[u]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
