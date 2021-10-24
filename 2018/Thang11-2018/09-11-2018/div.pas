Const   ginp='div.inp';
        gout='div.out';
        maxn=1000001;

Var     top,st,n:longint;
        d,q,dd:array[0..maxn] of longint;
        res1,res2:int64;

Procedure Sangnt;
Var     i,j:longint;
Begin
        for i:=2 to maxn do
                if d[i]=0 then
                begin
                        d[i]:=i;
                        for j:=i to maxn div i do d[i*j]:=i;
                end;
End;

Procedure Pt(x:longint);
Begin
        while x>1 do
        begin
                if dd[d[x]]=0 then
                begin
                        inc(top);
                        q[top]:=d[x];
                end;
                inc(dd[d[x]]);
                x:=x div d[x];
        end;
End;

Procedure Process;
Var     i:longint;
Begin
        readln(n);
        top:=0;
        pt(n); pt(n+1); pt(n+2);
        res1:=1; res2:=1;
        for i:=1 to top do
        begin
                res1:=res1*(dd[q[i]]+1);
                res2:=res2*(2*dd[q[i]]+1);
                dd[q[i]]:=0;
        end;
        writeln(res2 div 2-res1+1);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Sangnt;
        readln(st);
        while st>0 do
        begin
                Process;
                dec(st);
        end;
        Close(input); Close(output);
End.
