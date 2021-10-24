Uses    Math;

Const   ginp='swindow.inp';
        gout='swindow.out';
        maxn=2000010;

Var     n,m,k,res:longint;
        a,b:ansistring;
        z:array[0..maxn] of longint;
        d:array[0..maxn] of boolean;

Procedure Enter;
Begin
        readln(a); n:=length(a);
        readln(b); m:=length(b);
        read(k);
        a:=b+'@'+a;
        fillchar(d,sizeof(d),false);
End;

Procedure Process;
Var     i,l,r,minp:longint;
Begin
        z[1]:=0; l:=1; r:=1;
        for i:=2 to n+m+1 do
        begin
                if i<=r then z[i]:=min(z[i-l+1],r-i+1);
                while (i+z[i]<=n+m+1) and (a[1+z[i]]=a[i+z[i]]) do inc(z[i]);
                if r<i+z[i]-1 then
                begin
                        l:=i; r:=i+z[i]-1;
                end;
                if z[i]>=m then d[i-m-1]:=true;
        end;
        res:=0; minp:=n+1;
        for i:=n downto 1 do
        begin
                if d[i] then minp:=i-k+m;
                if (i>=minp) and (i+k-1<=n) then inc(res);
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
