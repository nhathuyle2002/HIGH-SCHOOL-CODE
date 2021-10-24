Uses    Math;

Const   ginp='daoday.inp';
        gout='daoday.out';
        mn=50;

Var     n:longint;
        a:array[0..mn+1] of longint;
        f:array[0..mn+1,0..mn+1,0..mn+1,0..mn+1] of longint;
        d:array[0..mn+1,0..mn+1] of boolean;

Procedure Dp(l,r:longint);
Var     x,y:longint;
Begin
        if d[l,r] then exit;
        d[l,r]:=true;
        if l>r then exit;
        if l=r then
        begin
                for x:=1 to a[l] do
                        for y:=a[l] to mn do f[l,r,x,y]:=1;
                exit;
        end;
        dp(l+1,r); dp(l,r-1); dp(l+1,r-1);

        for y:=a[l] to mn do f[l,r,a[l],y]:=f[l+1,r,a[l],y]+1;
        for x:=1 to a[r] do f[l,r,x,a[r]]:=max(f[l,r,x,a[r]],f[l,r-1,x,a[r]]+1);
        for y:=a[r] to mn do f[l,r,a[r],y]:=f[l+1,r-1,a[r],y]+1;
        for x:=1 to a[l] do f[l,r,x,a[l]]:=max(f[l,r,x,a[l]],f[l+1,r-1,x,a[l]]+1);

        if a[l]<=a[r] then
                f[l,r,a[l],a[r]]:=max(f[l,r,a[l],a[r]],f[l+1,r-1,a[l],a[r]]+2)
        else
                f[l,r,a[r],a[l]]:=max(f[l,r,a[r],a[l]],f[l+1,r-1,a[r],a[l]]+2);

        for x:=mn downto 1 do
                for y:=x to mn do
                        f[l,r,x,y]:=max(f[l,r,x,y],max(max(f[l,r-1,x,y],f[l+1,r,x,y]),max(f[l,r,x,y-1],f[l,r,x+1,y])));
End;

Procedure Enter;
Var     i:longint;
Begin
        readln(n);
        for i:=1 to n do readln(a[i]);
End;

Procedure Process;
Begin
        fillchar(d,sizeof(d),false);
        dp(1,n);
        write(f[1,n,1,mn]);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Process;
        Close(input); Close(output);
End.
