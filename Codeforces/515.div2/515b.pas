Uses    Math;

Const   ginp='ss.inp';
        gout='ss.out';
        maxn=1010;

Var     n,r:longint;
        d,l,f:array[0..maxn] of longint;

Procedure Enter;
Var     i,x:longint;
Begin
        readln(n,r);
        for i:=1 to n do
        begin
                read(x);
                if x=1 then
                begin
                        x:=min(i+r-1,n);
                        d[x]:=1;
                        if l[x]=0 then l[x]:=i-r+1;
                end;
        end;
End;

Procedure Process;
Var     i,j:longint;
Begin
        f[0]:=0;
        for i:=1 to n do
        begin
                f[i]:=maxn+1;
                if d[i]=1 then
                for j:=i downto 1 do
                        if j<l[i] then break else f[i]:=min(f[i],f[j-1]+1);
        end;
        if f[n]=maxn+1 then write(-1) else write(f[n]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
