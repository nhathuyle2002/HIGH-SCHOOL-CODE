Const   ginp='golds.inp';
        gout='golds.out';
        maxn=40;
        maxg=1000001;

Var     n,m:longint;
        res:int64;
        a:array[0..maxn] of longint;
        d:array[1..2,0..maxg] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to n do read(a[i]);
End;

Procedure Try(i,nn,sum,typ:longint);
Var     j:longint;
Begin
        if sum>m then exit;
        inc(d[typ,sum]);
        for j:=i+1 to nn do try(j,nn,sum+a[j],typ);
End;

Procedure Process;
Var     i:longint;
Begin
        try(0,n shr 1,0,1);
        d[1,0]:=1;
        try(n shr 1,n,0,2);
        d[2,0]:=1;
        for i:=1 to m do
                d[2,i]:=d[2,i-1]+d[2,i];
        res:=0;
        for i:=0 to m do res:=res+int64(d[1,i])*d[2,m-i];
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
