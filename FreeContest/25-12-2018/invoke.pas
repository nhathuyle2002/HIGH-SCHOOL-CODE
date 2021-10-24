Const   ginp='invoke.inp';
        gout='invoke.out';
        maxn=trunc(1e7)+10;

Var     st,n,top:longint;
        a,dd:array[1..7] of longint;
        d:array[0..maxn] of boolean;
        q:array[0..maxn] of longint;

Procedure Init;
Var     i,j:longint;
Begin
        fillchar(d,sizeof(d),true);
        d[0]:=false;
        d[1]:=false;
        for i:=2 to maxn do
                if d[i] then
                for j:=i to maxn div i do d[i*j]:=false;
End;

Procedure Enter;
Var     i:longint;
        s:string[10];
Begin
        readln(s);
        n:=length(s);
        for i:=1 to length(s) do
                a[i]:=ord(s[i])-48;
End;

Procedure Try(i,x:longint);
Var     j:longint;
Begin
        if d[x] then
        begin
                inc(top);
                q[top]:=x;
                d[x]:=false;
        end;
        if i=n+1 then exit;
        for j:=1 to n do
                if dd[j]=0 then
                begin
                        dd[j]:=1;
                        try(i+1,x*10+a[j]);
                        dd[j]:=0;
                end;
End;

Procedure Process;
Var     i:longint;
Begin
        top:=0;
        fillchar(dd,sizeof(dd),0);
        try(1,0);
        writeln(top);
        for i:=1 to top do d[q[i]]:=true;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Init;
        readln(st);
        for st:=1 to st do
        begin
                Enter;
                Process;
        end;
        Close(input); Close(output);
End.
