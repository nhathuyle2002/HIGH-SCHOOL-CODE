Const   ginp='viterbi.inp';
        gout='viterbi.out';
        maxn=201;

Var     n,m,k,vres:longint;
        c,ou:array[0..maxn] of longint;
        a,b,f,trace:array[0..maxn,0..maxn] of longint;

Procedure Answer(i,u:longint);
Begin
        if i=0 then exit;
        ou[i]:=u;
        answer(i-1,trace[i,u]);
End;

Procedure Enter;
Var     i,j:longint;
Begin
        readln(n,m,k);
        for i:=1 to k do read(c[i]);
        readln;
        for i:=1 to n do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
        for i:=1 to n do
        begin
                for j:=1 to m do read(b[i,j]);
                readln;
        end;
End;

Procedure Process;
Var     i,u,v:longint;
Begin
        for i:=1 to k do
                for u:=1 to n do
                begin
                        f[i,u]:=f[i-1,u]+b[u,c[i]];
                        trace[i,u]:=u;
                        for v:=1 to n do
                                if f[i,u]>f[i-1,v]+a[v,u]+b[u,c[i]] then
                                begin
                                        f[i,u]:=f[i-1,v]+a[v,u]+b[u,c[i]];
                                        trace[i,u]:=v;
                                end;
                end;
        vres:=1;
        for u:=2 to n do
                if f[k,u]<f[k,vres] then vres:=u;
        writeln(f[k,vres]);
        answer(k,vres);
        //for i:=1 to k do write(ou[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
