Const   ginp = 'pigs.inp';
        gout = 'pigs.out';
        maxn = 5010;

Type    edge = record y,link:longint; end;

Var     n:longint;
        e:array[-maxn..maxn] of edge;
        head:array[0..maxn] of longint;
        dd:array[0..maxn] of boolean;
        d:array[0..maxn] of longint;
        res:int64;
        sum1,sum2,sum3:array[0..maxn] of int64;

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
        readln(n);
        for i:=1 to n-1 do
        begin
                readln(u,v);
                add(i,u,v);
                add(-i,v,u);
        end;
End;

Procedure Dfs(u,def:longint);
Var     i:longint;
Begin
        dd[u]:=false;
        inc(d[def]);
        i:=head[u];
        while i<>0 do
        with e[i] do
        begin
                if dd[y] then dfs(y,def+1);
                i:=link;
        end;
End;

Procedure Process;
Var     u,v,i,def:longint;
Begin
        res:=0;
        for u:=1 to n do
        begin
                for v:=1 to n do dd[v]:=true;
                dd[u]:=false;
                for def:=1 to n-1 do
                begin
                        res:=res+sum3[def];
                        sum1[def]:=0; sum2[def]:=0; sum3[def]:=0;
                end;
                i:=head[u];
                while i<>0 do
                with e[i] do
                begin
                        dfs(y,1);
                        for def:=1 to n-1 do
                        begin
                                if d[def]=0 then break;
                                sum3[def]:=sum3[def]+sum2[def]*d[def];
                                sum2[def]:=sum2[def]+sum1[def]*d[def];
                                sum1[def]:=sum1[def]+d[def];
                                d[def]:=0;
                        end;
                        i:=link;
                end;
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
