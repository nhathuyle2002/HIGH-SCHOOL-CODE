Const   ginp='saw.inp';
        gout='saw.out';
        maxh=1000001;
        maxn=100010;

Var     n,m:longint;
        f:array[0..maxh+1] of int64;

Procedure Enter;
Var     i,x,cou:longint;
Begin
        readln(n,m);
        for i:=1 to n do
        begin
                read(x);
                inc(f[x]);
        end;
        readln;
        cou:=0;
        for i:=maxh downto 0 do
        begin
                cou:=cou+f[i];
                f[i]:=f[i+1]+cou-f[i];
        end;
End;

Procedure Process;
Var     i,l,r,mid:longint;
        x:int64;
Begin
        for i:=1 to m do
        begin
                read(x);
                l:=1; r:=maxh+1;
                while l<r do
                begin
                        mid:=(l+r) shr 1;
                        if f[mid]>=x then l:=mid+1 else r:=mid;
                end;
                write(l-1,' ');
        end;
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
