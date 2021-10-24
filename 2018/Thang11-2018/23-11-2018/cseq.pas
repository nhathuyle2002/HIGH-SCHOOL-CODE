Const   ginp='cseq.inp';
        gout='cseq.out';
        maxn=1000001;

Var     n:longint;
        m,res:int64;
        s:array[0..maxn] of int64;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,m);
        for i:=1 to n do
        begin
                read(s[i]);
                s[i]:=s[i]+s[i-1];
        end;
End;

Procedure Process;
Var     i,l,r,mid:longint;
Begin
        res:=0;
        for i:=1 to n do
        begin
                l:=0; r:=i-1;
                while l<r do
                begin
                        mid:=(l+r) shr 1;
                        if s[i]-s[mid]<=m then r:=mid else l:=mid+1;
                end;
                res:=res+i-l;
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
