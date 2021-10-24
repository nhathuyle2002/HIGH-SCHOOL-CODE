Uses    Math;

Const   ginp='liondance.inp';
        gout='liondance.out';
        maxn=4001;

Var     n,delta,res:longint;
        a,b,ou:array[0..maxn] of longint;
        f,p,di,dj:array[0..maxn,0..maxn] of longint;

Procedure Enter;
Var     i:longint;
Begin
        readln(n,delta);
        for i:=1 to n do read(a[i]); readln;
        for i:=1 to n do read(b[i]);
End;

Function Be(i1,j1,i2,j2:longint):boolean;
Begin
        if f[i1,j1]<f[i2,j2] then exit(true);
        if (f[i1,j1]=f[i2,j2]) and (a[i1]<a[i2]) then exit(true);
        exit(false);
End;

Procedure Init;
Var     i,j,jmax:longint;
Begin
        res:=0;
        for i:=n downto 1 do
        begin
                jmax:=n+1;
                for j:=n downto 1 do
                begin
                        p[i,j]:=0;
                        f[i,j]:=max(f[i+1,j],f[i,j+1]);
                        if a[i]=b[j] then
                        begin
                                f[i,j]:=f[i+1,jmax]+1;
                                p[i,j]:=j;
                        end;
                        if (a[i]-delta<=b[i]) and (a[i]+delta>=b[i]) and (f[i-1,jmax]<=f[i-1,j]) then jmax:=j;
                        if res<f[i,j] then res:=f[i,j];
                end;
        end;
        for i:=n downto 1 do
                for j:=n downto 1 do
                begin
                        if be(di[i,j+1],dj[i,j+1],di[i+1,j],dj[i+1,j]) then
                        begin
                                di[i,j]:=di[i+1,j];
                                dj[i,j]:=dj[i+1,j];
                        end else
                        begin
                                di[i,j]:=di[i,j+1];
                                dj[i,j]:=dj[i,j+1];
                        end;
                        if (p[i,j]<>0) and (not be(i,j,di[i,j],dj[i,j])) then
                        begin
                                di[i,j]:=i;
                                dj[i,j]:=p[i,j];
                        end;
                end;
End;

Procedure Tv(i,j,cou:longint);
Begin
        if cou=res+1 then exit;
        ou[cou]:=a[di[i,j]];
        tv(di[i,j]+1,dj[i,j]+1,cou+1);
End;

Procedure Process;
Var     i:longint;
Begin
        tv(1,1,1);
        writeln(res);
        for i:=1 to res do write(ou[i],' ');
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        Enter;
        Init;
        Process;
        Close(input); Close(output);
End.
