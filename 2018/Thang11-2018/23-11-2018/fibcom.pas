Uses    Math;

Const   ginp='fc.inp';
        gout='fc.out';
        maxn = 1001;
        maxm = 10001;

Var     n,m,res:longint;
        a,b:array[0..maxm] of longint;
        d:array[0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        readln(m);
        for i:=1 to m do readln(a[i],b[i]);
End;

Procedure Process;
Var     i,j,u,v,tmp,cou:longint;
Begin
        res:=n;
        for i:=1 to n do
        begin
                fillchar(d,sizeof(d),0);
                for j:=1 to m do
                begin
                        u:=(a[j]-i+1+n) mod n; if u=0 then u:=n;
                        v:=(b[j]-i+1+n) mod n; if v=0 then v:=n;
                        if u>v then
                        begin
                                tmp:=u; u:=v; v:=tmp;
                        end;
                        inc(d[u]); dec(d[v]);
                end;
                tmp:=0; cou:=0;
                for j:=1 to n do
                begin
                        cou:=cou+d[j];
                        if cou>0 then inc(tmp);
                end;
                res:=min(res,tmp);
        end;
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
