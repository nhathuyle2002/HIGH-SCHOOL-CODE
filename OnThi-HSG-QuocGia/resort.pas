Const   ginp='resort.inp';
        gout='resort.out';
        maxn=2001;

Var     m,n,p,q,b,res:longint;
        c0,sum:array[0..maxn,0..maxn] of longint;

Procedure Enter;
Var     i,j,x:longint;
Begin
        readln(m,n,p,q);
        readln(b);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(x);
                        if x=b then
                        begin
                                c0[i,j]:=1;
                                sum[i,j]:=0;
                        end else
                        if x<b then sum[i,j]:=-1 else sum[i,j]:=1;
                        c0[i,j]:=c0[i,j]+c0[i-1,j]+c0[i,j-1]-c0[i-1,j-1];
                        sum[i,j]:=sum[i,j]+sum[i-1,j]+sum[i,j-1]-sum[i-1,j-1];
                end;
                readln;
        end;
End;

Procedure Process;
Var     i,j,s,c:longint;
Begin
        res:=0;
        for i:=p to m do
                for j:=q to n do
                begin
                        s:=sum[i,j]-sum[i-p,j]-sum[i,j-q]+sum[i-p,j-q];
                        c:=c0[i,j]-c0[i-p,j]-c0[i,j-q]+c0[i-p,j-q];
                        if (s=0) and (c>0) then inc(res) else
                        if (s>0) and (c>=s) then inc(res) else
                        if (s<0) and (c>-s) then inc(res);
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
