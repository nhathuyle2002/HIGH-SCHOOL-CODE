Uses    Math;

Const   ginp='swindow.inp';
        gout='swindow.out';

Var     n,m,k,res:longint;
        a,b:ansistring;
        z:array[0..2000010] of longint;

Procedure Enter;
Begin
        readln(a);
        readln(b); m:=length(b);
        a:=b+'$&'+a; n:=length(a);
        read(k);
End;

Procedure Process;
Var     i,l,r,pos:longint;
Begin
        res:=0; pos:=0;
        if k<m then exit;
        z[1]:=0; l:=0; r:=0;
        for i:=2 to n do
        begin
                if i<=r then z[i]:=min(r-i+1,z[i-l+1]);
                while (i+z[i]<=n) and (a[1+z[i]]=a[i+z[i]]) do inc(z[i]);
                if r<i+z[i]-1 then
                begin
                        l:=i; r:=i+z[i]-1;
                end;
                if z[i]=m then
                begin
                        pos:=max(pos+1,max(m+3,i-k+m));
                        for pos:=pos to min(i,n-k+1) do inc(res);
                end;
        end;
End;

Procedure Answer;
Begin
        write(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Answer;
        Close(input); Close(output);
End.
